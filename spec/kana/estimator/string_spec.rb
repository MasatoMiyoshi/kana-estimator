RSpec.describe Kana::Estimator::String do
  describe "to_kana" do
    it 'transforms hiragana into kana' do
      expect(Kana::Estimator::String.to_kana('取り込み')).to eq('取リ込ミ')
    end
  end

  describe "kana?" do
    it "judges that text is kana" do
      expect(Kana::Estimator::String.kana?('サイトブリッジ')).to eq(true)
      expect(Kana::Estimator::String.kana?('サイトブリッジ株')).to eq(false)
      expect(Kana::Estimator::String.kana?('とくしま')).to eq(false)
      expect(Kana::Estimator::String.kana?('徳島県')).to eq(false)
    end
  end

  describe "include_kana?" do
    it "judges that text includes kana" do
      expect(Kana::Estimator::String.include_kana?('サイトブリッジ')).to eq(true)
      expect(Kana::Estimator::String.include_kana?('サイトブリッジ株')).to eq(true)
      expect(Kana::Estimator::String.include_kana?('とくしま')).to eq(false)
      expect(Kana::Estimator::String.include_kana?('徳島県')).to eq(false)
    end
  end
end
