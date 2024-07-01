require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build(:product) }  # Using FactoryBot factory to build a Product object

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without price" do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without stock_quantity" do
    subject.stock_quantity = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with duplicate SKU" do
    existing_product = create(:product, sku: "56ES")  # Create a product with the same SKU using the factory
    subject.sku = "56ES"  # Set the same SKU on the test subject
    expect(subject).to_not be_valid
  end
end
