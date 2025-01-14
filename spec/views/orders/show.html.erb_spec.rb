require 'rails_helper'

RSpec.describe "orders/show.html.erb", type: :view do
  let(:product) { create(:product) }
  let(:order) { create(:order) }
  let(:order_item) { create(:order_item, order: order, product: product) }

  before do
    assign(:order, order)
    assign(:order_items, [ order_item ])
    render
  end

  it "displays the order details" do
    expect(rendered).to have_content(order.address)
    expect(rendered).to have_content(order.payment_method)
  end

  it "displays the order items" do
    expect(rendered).to have_content(order_item.product.name)
    expect(rendered).to have_content(order_item.quantity)
    expect(rendered).to have_content(order_item.total_price)
  end
end
