# spec/factories/products.rb
require 'faker'

FactoryBot.define do
  factory :product do
    name { Faker::Food.dish }
    sku { Faker::Alphanumeric.alphanumeric(number: 5, min_alpha: 3, min_numeric: 2).upcase }
    price { Faker::Commerce.price(range: 1.00..100.00) }
    stock_quantity { Faker::Number.between(from: 1, to: 100) }
  end
end
