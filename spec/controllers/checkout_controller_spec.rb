require 'rails_helper'
require 'vcr'
require 'ostruct'

RSpec.describe CheckoutController, type: :controller do
  let!(:user) { create(:user) }
  let!(:product) { create(:product, price: 2999.00) }
  let!(:cart) { create(:cart, user: user) }
  let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 1) }
  let!(:delivery_option) { create(:delivery_option, name: 'Standard Delivery', price: 5.00) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    it 'creates a Stripe Checkout session and redirects to the session URL' do
      allow(Stripe::Checkout::Session).to receive(:create).and_return(OpenStruct.new(url: 'https://checkout.stripe.com/c/pay/test_session'))

      post :create, params: { confirm_address: 'yes', cart: { delivery_option_id: delivery_option.id } }

      expect(response).to redirect_to(/https:\/\/checkout\.stripe\.com\/c\/pay\//)
    end

    it 'includes the delivery option in the Stripe Checkout session' do
      allow(Stripe::Checkout::Session).to receive(:create).and_return(OpenStruct.new(url: 'https://checkout.stripe.com/c/pay/test_session'))

      post :create, params: { confirm_address: 'yes', cart: { delivery_option_id: delivery_option.id } }

      expect(Stripe::Checkout::Session).to have_received(:create).with(
        hash_including(
          line_items: array_including(
            hash_including(
              price_data: hash_including(
                product_data: hash_including(name: 'Standard Delivery'),
                unit_amount: (delivery_option.price * 100).to_i
              )
            )
          )
        )
      )
    end
  end

  describe 'GET #success' do
    it 'renders the success template' do
      get :success
      expect(response).to render_template(:success)
    end
  end

  describe 'GET #cancel' do
    it 'renders the cancel template' do
      get :cancel
      expect(response).to render_template(:cancel)
    end
  end
end
