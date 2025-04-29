require 'rails_helper'

RSpec.describe "carts/show.html.erb", type: :view do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:product1) { create(:product, price: 2999.00) }
  let(:product2) { create(:product, price: 999.99) }
  let!(:cart_item1) { create(:cart_item, cart: cart, product: product1, quantity: 1) }
  let!(:cart_item2) { create(:cart_item, cart: cart, product: product2, quantity: 1) }

  before do
    allow(view).to receive(:current_user).and_return(user)
    create(:address, user: user)
    assign(:cart, cart)
    render
  end
  

  it "displays the total price of all items in the cart" do
    expect(rendered).to have_selector("tfoot th", text: "Subtotal")
    expect(rendered).to have_selector("tfoot th", text: "$3,998.99")
  end

  it "displays each cart item" do
    expect(rendered).to have_content(product1.name)
    expect(rendered).to have_content(product2.name)
    expect(rendered).to have_content("$2,999.00")
    expect(rendered).to have_content("$999.99")
  end

  it "displays the delivery option selection" do
    expect(rendered).to have_content("Select Delivery Option")
  end

  it "displays the checkout button" do
    expect(rendered).to have_button("Proceed to Checkout")
  end
end
