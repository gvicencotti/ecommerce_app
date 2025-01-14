require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart) { create(:cart) }
  let(:product) { create(:product, price: 2999.00) }
  let(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 2) }

  it 'belongs to a cart' do
    expect(cart_item.cart).to eq(cart)
  end

  it 'belongs to a product' do
    expect(cart_item.product).to eq(product)
  end

  it 'validates quantity presence' do
    cart_item.quantity = nil
    expect(cart_item).not_to be_valid
  end

  it 'validates quantity numericality' do
    cart_item.quantity = 0
    expect(cart_item).not_to be_valid
  end

  it 'calculates total price' do
    expect(cart_item.total_price).to eq(product.price * cart_item.quantity)
  end
end
