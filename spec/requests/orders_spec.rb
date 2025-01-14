require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }

  before do
    sign_in user
    user.create_cart # Ensure the user has a cart
  end

  describe "GET /new" do
    it "returns http success" do
      get new_order_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post orders_path, params: { order: { address: "123 Main St", payment_method: "Credit Card" } }
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get order_path(order)
      expect(response).to have_http_status(:success)
    end
  end
end
