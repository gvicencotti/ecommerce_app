require 'rails_helper'

RSpec.describe "CartItems", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:cart) { create(:cart, user: user) }
  let(:cart_item) { create(:cart_item, cart: cart, product: product) }

  before { sign_in user }

  describe "POST /create" do
    it "creates a new cart item" do
      post cart_items_path, params: { cart_item: { product_id: product.id, quantity: 1 } }
      expect(response).to redirect_to(cart_path)
    end
  end

  describe "PATCH /update" do
    it "updates the cart item" do
      patch cart_item_path(cart_item), params: { cart_item: { quantity: 2 } }
      expect(response).to redirect_to(cart_path)
    end
  end

  describe "DELETE /destroy" do
    it "destroys the cart item" do
      delete cart_item_path(cart_item)
      expect(response).to redirect_to(cart_path)
    end
  end
end
