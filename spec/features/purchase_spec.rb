require 'rails_helper'
require 'webmock/rspec'

RSpec.feature "Purchase Process", type: :feature do
  let!(:user) { create(:user) }
  let!(:category) { create(:category, name: "Electronics") }
  let!(:vendor) { create(:user) }
  let!(:product) { create(:product, user: vendor, name: "Unique Product Name", category: category) }
  let!(:delivery_option) { create(:delivery_option, name: 'Standard Delivery', price: 5.00) }

  scenario "User adds products to the cart and completes a purchase" do
    stub_request(:post, "https://api.stripe.com/v1/checkout/sessions").
      to_return(status: 200, body: {
        id: 'cs_test_a16OHoI2X3VgxkjasOvrqT3zvWEyX4DPBEPKLY6vzegnY5K8ueAB3p8dnK',
        payment_status: 'paid',
        url: 'https://checkout.stripe.com/pay/cs_test_a16OHoI2X3VgxkjasOvrqT3zvWEyX4DPBEPKLY6vzegnY5K8ueAB3p8dnK'
      }.to_json, headers: { 'Content-Type' => 'application/json' })

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit products_path
    within("#product_#{product.id}") do
      click_button 'Add to Cart'
    end

    visit cart_path
    expect(page).to have_content(product.name)

    select 'Standard Delivery', from: 'cart_delivery_option_id'
    click_button 'Checkout'

    visit checkout_success_path

    expect(page).to have_content('Thank you for your purchase')
  end
end
