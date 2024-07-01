require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /products" do
    it "returns successful response" do
      get products_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /products/:id" do
    let(:product) { Product.create(name: "Test", sku: "ksu2", price: 10.0, stock_quantity: 100) }

    it "returns a successful response" do
      get product_path(product)
      expect(response).to have_http_status(200)
    end
  end
end
