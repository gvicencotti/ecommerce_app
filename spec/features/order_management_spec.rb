require 'rails_helper'

RSpec.feature "Order Management", type: :feature do
  let!(:user) { create(:user) }
  let!(:product) { create(:product, name: "Product 1", price: 19.99) }
  let!(:cart) { create(:cart, user: user) }
  let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 2) }

  before do
    login_as(user, scope: :user)
  end

  scenario "User creates an order" do
    visit new_order_path

    fill_in 'Address', with: '123 Main St'
    select 'Credit Card', from: 'Payment method'
    click_button 'Place Order'

    expect(page).to have_content('Order was successfully created.')
  end

  scenario "User views an order" do
    order = create(:order, user: user, address: '123 Main St', payment_method: 'Credit Card')
    create(:order_item, order: order, product: product, quantity: 2)

    visit order_path(order)

    expect(page).to have_content('123 Main St')
    expect(page).to have_content('Credit Card')
    expect(page).to have_content(product.name)
    expect(page).to have_content('2')
    expect(page).to have_content('39.98')
  end
end
