require 'rails_helper'

RSpec.describe "Products", type: :request do

  let(:product) { create(:product) }

  describe "GET /products" do
    it "returns successful response" do
      get products_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /products/:id" do
    it "returns a successful response" do
      get product_path(product)
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /products" do
    let(:valid_attributes) { attributes_for(:product) }

    it "creates a new product" do
      expect {
        post "/products", params: { product: valid_attributes }
      }.to change(Product, :count).by(1)
    end

    it "redirects to the created product" do
      post "/products", params: { product: valid_attributes }
      expect(response).to redirect_to(Product.last)
    end

    let(:invalid_attributes) { { name: nil, sku: nil, price: nil, stock_quantity: nil } }

    it "does not create a new product with invalid attributes" do
      expect {
        post "/products", params: { product: invalid_attributes }
      }.to_not change(Product, :count)

      expect(response).to have_http_status(422) # Unprocessable Entity
    end
  end

  describe "PATCH /products/:id" do
    let(:new_attributes) { { name: "Updated Product" } }

    it "updates the requested product" do
      patch "/products/#{product.id}", params: { product: new_attributes }
      product.reload
      expect(product.name).to eq(new_attributes[:name])
    end

    let(:invalid_attributes) { { name: nil } }

    it "does not update the requested product with invalid attributes" do
      patch "/products/#{product.id}", params: { product: invalid_attributes }
      product.reload
      expect(product.name).to_not eq(invalid_attributes[:name])

      expect(response).to have_http_status(422) # Unprocessable Entity
    end
  end

  describe "DELETE /products/:id" do
    it "destroys the requested product" do
      product_to_destroy = product
      expect {
        delete "/products/#{product_to_destroy.id}"
      }.to change(Product, :count).by(-1)
    end

    it "does not destroy product if id not found" do
      expect { delete "/products/-1" }.to_not change(Product, :count)
      expect(response).to have_http_status(404) # Not Found
    end
  end

end