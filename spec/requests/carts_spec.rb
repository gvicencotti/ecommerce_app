require 'rails_helper'

RSpec.describe "Carts", type: :request do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:product1) { create(:product, price: 2999.00) }
  let(:product2) { create(:product, price: 999.99) }
  let!(:cart_item1) { create(:cart_item, cart: cart, product: product1, quantity: 1) }
  let!(:cart_item2) { create(:cart_item, cart: cart, product: product2, quantity: 1) }

  before do
    sign_in user
  end

  describe "GET /cart" do
    it "displays the total price of all items in the cart" do
      get cart_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Total: $3,998.99")
    end
  end
end
