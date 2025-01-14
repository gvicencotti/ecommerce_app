require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order) { create(:order) }
  let(:product) { create(:product) }
  let(:order_item) { create(:order_item, order: order, product: product, quantity: 2) }

  it 'belongs to an order' do
    expect(order_item.order).to eq(order)
  end

  it 'belongs to a product' do
    expect(order_item.product).to eq(product)
  end

  it 'validates quantity presence' do
    order_item.quantity = nil
    expect(order_item).not_to be_valid
  end

  it 'validates quantity numericality' do
    order_item.quantity = 0
    expect(order_item).not_to be_valid
  end

  it 'calculates total price' do
    expect(order_item.total_price).to eq(product.price * order_item.quantity)
  end
end
