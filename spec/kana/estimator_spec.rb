RSpec.shared_examples_for "estimates yomi" do |word, yomi, result|
  it "estimates yomi" do
    expect(Kana::Estimator.new(word, yomi).estimate).to eq(result)
  end
end

RSpec.describe Kana::Estimator do
  it "has a version number" do
    expect(Kana::Estimator::VERSION).not_to be nil
  end

  describe "estimate" do
    context "hiragana and kanji" do
      word = 'お正月'
      yomi = 'オショーガツ'
      result = [['お', nil], ['正月', 'ショーガツ']]
      it_behaves_like "estimates yomi", word, yomi, result

      word = '戦う'
      yomi = 'タタカウ'
      result = [['戦', 'タタカ'], ['う', nil]]
      it_behaves_like "estimates yomi", word, yomi, result

      word = '取り込み'
      yomi = 'トリコミ'
      result = [['取', 'ト'], ['り', nil], ['込', 'コ'], ['み', nil]]
      it_behaves_like "estimates yomi", word, yomi, result

      word = '男の子'
      yomi = 'オトコノコ'
      result = [['男', 'オトコ'], ['の', nil], ['子', 'コ']]
      it_behaves_like "estimates yomi", word, yomi, result

      word = '月は東に日は西に'
      yomi = 'ツキハヒガシニヒハニシニ'
      result = [['月', 'ツキ'],
                ['は', nil],
                ['東', 'ヒガシ'],
                ['に', nil],
                ['日', 'ヒ'],
                ['は', nil],
                ['西', 'ニシ'],
                ['に', nil]]
      it_behaves_like "estimates yomi", word, yomi, result

      word = 'ヒヒ日'
      yomi = 'ヒヒヒ'
      result = [['ヒヒ', nil], ['日', 'ヒ']]
      it_behaves_like "estimates yomi", word, yomi, result
    end

    context "katakana and kanji" do
      word = 'アメリカ産'
      yomi = 'アメリカサン'
      result = [['アメリカ', nil], ['産', 'サン']]
      it_behaves_like "estimates yomi", word, yomi, result

      word = '立方メートル'
      yomi = 'リッポウメートル'
      result = [['立方', 'リッポウ'], ['メートル', nil]]
      it_behaves_like "estimates yomi", word, yomi, result
    end

    context "alphabet and kanji" do
      word = 'SiteBridge株式会社'
      yomi = 'サイトブリッジカブシキガイシャ'
      result = [['SiteBridge株式会社', 'サイトブリッジカブシキガイシャ']]
      it_behaves_like "estimates yomi", word, yomi, result
    end

    context "only hiragana" do
      word = 'はじめまして'
      yomi = 'ハジメマシテ'
      result = [['はじめまして', nil]]
      it_behaves_like "estimates yomi", word, yomi, result
    end

    context "only katakana" do
      word = 'イギリス'
      yomi = 'イギリス'
      result = [['イギリス', nil]]
      it_behaves_like "estimates yomi", word, yomi, result
    end

    context "only kanji" do
      word = '月'
      yomi = 'ツキ'
      result = [['月', 'ツキ']]
      it_behaves_like "estimates yomi", word, yomi, result
    end
  end
end
