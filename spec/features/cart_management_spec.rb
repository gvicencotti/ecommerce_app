require 'rails_helper'

RSpec.describe 'Cart Management', type: :feature do
  let(:user) { create(:user) }  # Alterado de :admin para :user
  let(:product) { create(:product, name: 'Product 1', price: 19.99) }

  before do
    login_as(user, scope: :user)
    user.create_cart  # Certifique-se de que o usuário tenha um carrinho
  end

  scenario 'User adds a product to the cart' do
    visit product_path(product)
    fill_in 'Quantity', with: '2'
    click_button 'Add to Cart'

    visit cart_path
    within('tr', text: 'Product 1') do
      expect(find('input[type="number"]').value).to eq('2')
      expect(page).to have_content('$39.98')
    end
  end

  scenario 'User updates the quantity of a cart item' do
    create(:cart_item, cart: user.cart, product: product, quantity: 1)

    visit cart_path
    within('tr', text: 'Product 1') do
      fill_in 'cart_item_quantity', with: '3'
      click_button 'Update'
    end
    within('tr', text: 'Product 1') do
      expect(find('input[type="number"]').value).to eq('3')
      expect(page).to have_content('$59.97')
    end
  end

  scenario 'User removes a product from the cart' do
    create(:cart_item, cart: user.cart, product: product, quantity: 1)

    visit cart_path
    within('tr', text: 'Product 1') do
      click_button 'Remove'
    end

    expect(page).not_to have_content('Product 1')
  end
end
