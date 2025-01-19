require 'rails_helper'
require 'webmock/rspec'

RSpec.feature "Purchase Process", type: :feature do
  let!(:user) { create(:user) }
  let!(:category) { create(:category, name: "Electronics") }
  let!(:vendor) { create(:user) }
  let!(:product) { create(:product, user: vendor, name: "Unique Product Name", category: category) }

  scenario "User adds products to the cart and completes a purchase" do
    # Mock Stripe Checkout Session
    stub_request(:post, "https://api.stripe.com/v1/checkout/sessions").
      to_return(status: 200, body: {
        id: 'cs_test_a16OHoI2X3VgxkjasOvrqT3zvWEyX4DPBEPKLY6vzegnY5K8ueAB3p8dnK',
        payment_status: 'paid',
        url: 'https://checkout.stripe.com/pay/cs_test_a16OHoI2X3VgxkjasOvrqT3zvWEyX4DPBEPKLY6vzegnY5K8ueAB3p8dnK'
      }.to_json, headers: { 'Content-Type' => 'application/json' })

    # User signs in
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    # Add product to cart
    visit products_path
    within("#product_#{product.id}") do
      click_button 'Add to Cart'
    end

    # Visit cart and verify product is added
    visit cart_path
    expect(page).to have_content(product.name)  # Matches the unique product name

    # Attempt to checkout
    click_button 'Checkout'

    # Simulate successful checkout
    visit checkout_success_path

    # Verify checkout process
    expect(page).to have_content('Thank you for your purchase')
  end
end
