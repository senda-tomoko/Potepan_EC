require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    let(:product) { create(:product, name: "Sample Product") }

    it "商品詳細ページ遷移時に正常にタイトルを取得できること" do
      expect(helper.full_title(product.name)).to eq("#{product.name} - BIGBAG Store")
    end

    it "ページタイトルが空の場合にベースタイトルを返すこと" do
      expect(helper.full_title('')).to eq("BIGBAG Store")
    end
  end
end
