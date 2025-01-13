require 'rails_helper'

RSpec.describe "Carts", type: :request do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }

  before { sign_in user }

  describe "GET /show" do
    it "returns http success" do
      get cart_path
      expect(response).to have_http_status(:success)
    end
  end
end
