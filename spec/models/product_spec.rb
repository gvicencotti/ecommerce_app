require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    product = Product.new(name: 'Sample Product', description: 'A sample product', price: 9.99)
    expect(product).to be_valid
  end

  it "is invalid without a name" do
    product = Product.new(name: nil, price: 9.99)
    expect(product).not_to be_valid
  end

  it "is invalid without a price" do
    product = Product.new(name: 'Sample Product', price: nil)
    expect(product).not_to be_valid
  end

  it "is invalid with a negative price" do
    product = Product.new(name: 'Sample Product', price: -1)
    expect(product).not_to be_valid
  end
end