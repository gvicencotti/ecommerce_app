require 'rails_helper'

RSpec.describe 'Order Management', type: :feature do
  let(:user) { create(:user) }
  let(:product) { create(:product, name: 'Product 1', price: 19.99) }

  before do
    login_as(user, scope: :user)
    user.create_cart
    create(:cart_item, cart: user.cart, product: product, quantity: 2)
  end

  scenario 'User creates an order' do
    visit new_order_path
    fill_in 'Address', with: '123 Main St'
    select 'Credit Card', from: 'order_payment_method'
    click_button 'Place Order'

    expect(page).to have_content('Order was successfully created.')
    expect(page).to have_content('123 Main St')
    expect(page).to have_content('Credit Card')
    expect(page).to have_content('$39.98')
  end

  scenario 'User views an order' do
    order = create(:order, user: user, address: '123 Main St', payment_method: 'Credit Card')
    create(:order_item, order: order, product: product, quantity: 2)

    visit order_path(order)
    expect(page).to have_content('123 Main St')
    expect(page).to have_content('Credit Card')
    expect(page).to have_content('Product 1')
    expect(page).to have_content('2')
    expect(page).to have_content('$39.98')
  end
end
