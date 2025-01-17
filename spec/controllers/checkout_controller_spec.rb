require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product, price: 1000) }
  let(:cart) { create(:cart, user: user) }
  let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 2) }

  before do
    sign_in user
  end

  describe 'POST #create', :vcr do
    it 'creates a Stripe Checkout session and redirects to the session URL' do
      post :create

      expect(response).to redirect_to(/https:\/\/checkout.stripe.com\/c\/pay\/.*/)
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
