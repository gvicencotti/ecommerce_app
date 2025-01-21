require 'rails_helper'
require 'vcr'

RSpec.describe CheckoutController, type: :controller do
  let!(:user) { create(:user) }
  let!(:product) { create(:product, price: 2999.00) }
  let!(:cart) { create(:cart, user: user) }
  let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 1) }
  let!(:delivery_option) { create(:delivery_option, name: 'Standard Delivery', price: 5.00) }

  before do
    sign_in user
  end

  describe "POST #create" do
    it "creates a Stripe Checkout session and redirects to the session URL" do
      VCR.use_cassette("stripe_checkout_session") do
        post :create, params: { cart: { delivery_option_id: delivery_option.id } }
        expect(response).to redirect_to(/https:\/\/checkout\.stripe\.com\/c\/pay\//)
      end
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
