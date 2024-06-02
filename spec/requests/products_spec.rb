require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /products/:id" do
    let(:product) { create(:product) }
    let(:image) { create(:image) }

    # 画像URLの取得が上手くいかない問題への対応
    # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
    let!(:filename) do
      filename = image.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    end

    before do
      product.images << image
      get product_path(product.id)
    end

    it "商品ページのHTTPリクエストが成功すること" do
      expect(response).to have_http_status(:success)
    end

    it "商品名が取得できること" do
      expect(response.body).to include(product.name)
    end

    it "価格が取得できること" do
      expect(response.body).to include(product.display_price.to_s)
    end

    it "商品画像のファイル名がレスポンスに含まれていること" do
      expect(response.body).to include(filename)
    end
  end
end
