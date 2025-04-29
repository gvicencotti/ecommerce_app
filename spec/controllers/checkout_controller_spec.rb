require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { create(:user) }
  let(:address) { create(:address, user: user) }
  let(:product) { create(:product) }
  let(:cart) { create(:cart, user: user) }
  let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 2) }
  let(:delivery_option) { create(:delivery_option, price: 10.0) }

  before do
    allow(Stripe::Checkout::Session).to receive(:create)
    sign_in user
    cart.update(delivery_option: delivery_option)
    user.update(address: address)
  end

  describe 'POST #create', :vcr do
    before do
      allow(Stripe::Checkout::Session).to receive(:create).and_return(OpenStruct.new(url: 'https://checkout.stripe.com'))
    end

    it 'redirects to Stripe checkout session' do
      post :create, params: { confirm_address: 'yes', cart: { delivery_option_id: delivery_option.id } }
      expect(response).to redirect_to(/https:\/\/checkout\.stripe\.com/)
    end

    it 'sets the delivery option' do
      post :create, params: { confirm_address: 'yes', cart: { delivery_option_id: delivery_option.id } }
      expect(cart.reload.delivery_option).to eq(delivery_option)
    end

    it 'redirects to confirm address if address is not confirmed' do
      allow(Stripe::Checkout::Session).to receive(:create)
    
      post :create, params: { confirm_address: 'no', cart: { delivery_option_id: delivery_option.id } }
      
      expect(response).to redirect_to(cart_path)
    end
  end

  describe 'GET #success' do
    before do
      allow(Stripe::Checkout::Session).to receive(:create).and_return(OpenStruct.new(url: 'https://checkout.stripe.com'))
    end

    it 'creates an order and order items' do
      get :success
      order = user.orders.last
      expect(order).not_to be_nil
      expect(order.order_items.count).to eq(1)
      expect(order.order_items.first.product).to eq(product)
    end

    it 'clears the cart items' do
      get :success
      expect(cart.cart_items.count).to eq(0)
    end

    it 'redirects to the order show page' do
      get :success
      order = user.orders.last
      expect(response).to redirect_to(order_path(order))
    end
  end

  describe 'GET #cancel' do
    it 'renders the cancel template' do
      get :cancel
      expect(response).to render_template(:cancel)
    end
  end
end