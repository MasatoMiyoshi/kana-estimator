module Kana
  class Estimator
    class String
      class << self
        def to_kana(text)
          text.tr('ぁ-ん', 'ァ-ン')
        end

        def kana?(text)
          text.match?(/^[ァ-ン]+$/)
        end

        def include_kana?(text)
          text.match?(/[ァ-ン]/)
        end
      end
    end
  end
end
