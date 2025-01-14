require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:product) { create(:product) }
  let(:cart_item) { create(:cart_item, cart: cart, product: product) }

  it 'belongs to a user' do
    expect(cart.user).to eq(user)
  end

  it 'has many cart items' do
    cart.cart_items << cart_item
    expect(cart.cart_items).to include(cart_item)
  end

  it 'has many products through cart items' do
    cart.cart_items << cart_item
    expect(cart.products).to include(product)
  end

  it 'destroys associated cart items when destroyed' do
    cart.cart_items << cart_item
    expect { cart.destroy }.to change { CartItem.count }.by(-1)
  end
end
