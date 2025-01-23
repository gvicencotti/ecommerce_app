require 'rails_helper'

RSpec.describe "Addresses", type: :request do
  describe "GET /new" do
    it "returns http success" do
      user = FactoryBot.create(:user)
      sign_in user
      get new_user_address_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      user = FactoryBot.create(:user)
      _address = FactoryBot.create(:address, user: user)
      sign_in user
      get edit_user_address_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new address and redirects to the user profile" do
      user = FactoryBot.create(:user)
      sign_in user
      post user_address_path(user), params: { address: FactoryBot.attributes_for(:address) }
      expect(response).to redirect_to(user_path(user))
      follow_redirect!
      expect(response.body).to include("Address saved successfully.")
    end
  end

  describe "PATCH /update" do
    it "updates the address and redirects to the user profile" do
      user = FactoryBot.create(:user)
      address = FactoryBot.create(:address, user: user)
      sign_in user
      patch user_address_path(user), params: { address: { street: "New Street" } }
      expect(response).to redirect_to(user_path(user))
      follow_redirect!
      expect(response.body).to include("Address updated successfully.")
      expect(address.reload.street).to eq("New Street")
    end
  end
end
