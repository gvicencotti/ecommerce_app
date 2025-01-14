require 'rails_helper'

RSpec.describe "carts/show.html.erb", type: :view do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:product1) { create(:product, price: 2999.00) }
  let(:product2) { create(:product, price: 999.99) }
  let!(:cart_item1) { create(:cart_item, cart: cart, product: product1, quantity: 1) }
  let!(:cart_item2) { create(:cart_item, cart: cart, product: product2, quantity: 1) }

  before do
    assign(:cart, cart)
    render
  end

  it "displays the total price of all items in the cart" do
    expect(rendered).to have_content("Total: $3,998.99")
  end

  it "displays each cart item" do
    expect(rendered).to have_content(product1.name)
    expect(rendered).to have_content(product2.name)
    expect(rendered).to have_content("$2,999.00")
    expect(rendered).to have_content("$999.99")
  end
end
