require 'rails_helper'

RSpec.describe "orders/new.html.erb", type: :view do
  before do
    assign(:order, Order.new)
    render
  end

  it "displays the new order form" do
    expect(rendered).to have_field('Address')
    expect(rendered).to have_select('Payment method')
    expect(rendered).to have_button('Place Order')
  end
end
