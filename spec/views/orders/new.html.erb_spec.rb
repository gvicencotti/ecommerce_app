require 'rails_helper'

RSpec.describe "orders/new.html.erb", type: :view do
  before do
    assign(:order, Order.new)
    render
  end

  it "displays the new order form" do
    expect(rendered).to have_selector('form')
    expect(rendered).to have_field('order_address')
    expect(rendered).to have_field('order_payment_method')
    expect(rendered).to have_button('Place Order')
  end
end
