require "kana/estimator/string"
require "kana/estimator/version"

module Kana
  class Estimator
    def initialize(word, yomi)
      @word = word
      @yomi = yomi
    end

    def estimate
      idxs = select_kana_indices(@word, @yomi)
      construct_word_yomi_array(@word, @yomi, idxs)
    end

    private

    def select_kana_indices(word, yomi)
      word_kana = String.to_kana(word)
      yomi_kana = String.to_kana(yomi)

      word_chars = word_kana.chars
      yomi_chars = yomi_kana.chars

      idxs = []
      pos = 0
      word_chars.each_with_index do |w, widx|
        if String.kana?(w)
          chars = yomi_chars[pos..]
          yidxs = chars.each_index.select { |i| chars[i] == w }
          yidxs.each do |yidx|
            yidx += pos

            next if !idxs.empty? && (yidx - idxs[-1][1]) == 1 && (widx - idxs[-1][0]) > 1

            idxs << [widx, yidx]
            break
          end
        end

        pos = widx + 1
      end

      idxs
    end

    def construct_word_yomi_array(word, yomi, idxs)
      word_chars = word.chars
      yomi_chars = yomi.chars

      wpos = 0
      ypos = 0
      words_yomis = idxs.each_with_object([]) do |(widx, yidx), words_yomis|
                      if (widx - wpos) > 0
                        w = word_chars.slice(wpos, widx - wpos).join
                        y = yomi_chars.slice(ypos, yidx - ypos).join
                        y = nil unless String.include_kana?(y)
                        words_yomis << [w, y]
                      end

                      w = word_chars[widx]
                      words_yomis << [w, nil]

                      wpos = widx + 1
                      ypos = yidx + 1
                      words_yomis
                    end

      w = word_chars.slice(wpos..).join
      y = yomi_chars.slice(ypos..).join
      y = nil if w.empty? || y.empty? || !String.include_kana?(y)
      words_yomis << [w, y]

      words_yomis.each_with_object([]) do |(w, y), wys|
        if !wys.empty? && wys[-1][1].nil? && y.nil?
          wys[-1][0] << w
        else
          wys << [w, y]
        end
      end
    end
  end
end
