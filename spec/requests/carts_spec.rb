require 'rails_helper'

RSpec.describe "Carts", type: :request do
  let!(:user) { create(:user) }
  let!(:product1) { create(:product, price: 2999.00) }
  let!(:product2) { create(:product, price: 999.99) }
  let!(:cart) { create(:cart, user: user) }
  let!(:cart_item1) { create(:cart_item, cart: cart, product: product1, quantity: 1) }
  let!(:cart_item2) { create(:cart_item, cart: cart, product: product2, quantity: 1) }

  before do
    sign_in user
  end

  describe "GET /cart" do
    it "displays the total price of all items in the cart" do
      get cart_path
      expect(response.body).to include("<th colspan=\"3\" class=\"text-right\">Subtotal</th>")
      expect(response.body).to include("<th>$3,998.99</th>")
    end
  end
end
