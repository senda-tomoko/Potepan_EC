require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    it "商品詳細ページ遷移時に正常にタイトルを取得できること" do
      expect(helper.full_title("Sample Product")).to eq("Sample Product - BIGBAG Store")
    end

    it "引数を設定しない場合にデフォルトのタイトルを取得できること" do
      expect(helper.full_title('')).to eq("BIGBAG Store")
    end

    it "引数がnilの場合にデフォルトのタイトルを取得できること" do
      expect(helper.full_title(nil)).to eq("BIGBAG Store")
    end
  end
end
