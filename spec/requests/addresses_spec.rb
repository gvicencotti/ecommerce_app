# #testes serão ajustados posteriormente
# 
# require 'rails_helper'
# 
# RSpec.describe "Addresses", type: :request do
#   let(:admin) { create(:user) }
#   let(:address) { create(:address, user: admin) }
# 
#   before do
#     sign_in admin
#   end
# 
#   describe "GET /new" do
#     it "returns http success for the admin's address" do
#       get new_user_address_path(admin)
#       expect(response).to have_http_status(:success)
#     end
#   end
# 
#   describe "GET /edit" do
#     it "returns http success for editing the admin's address" do
#       get edit_user_address_path(admin)
#       expect(response).to have_http_status(:success)
#     end
#   end
# 
#   describe "POST /create" do
#     context "with valid parameters" do
#       it "creates a new address and redirects to the user's profile" do
#         address_params = attributes_for(:address)
#         expect {
#           post user_address_path(admin), params: { address: address_params }
#         }.to change(Address, :count).by(1)
# 
#         expect(response).to redirect_to(user_path(admin))
#       end
#     end
# 
#     context "with invalid parameters" do
#       it "does not create a new address and re-renders the new template" do
#         invalid_params = attributes_for(:address, street: nil)
#         expect {
#           post user_address_path(admin), params: { address: invalid_params }
#         }.not_to change(Address, :count)
# 
#         expect(response).to have_http_status(:unprocessable_entity).or have_http_status(:ok)
#       end
#     end
#   end
# 
#   describe "PATCH /update" do
#     context "with valid parameters" do
#       it "updates the address and redirects to the user's profile" do
#         new_attributes = { street: "Updated Street Name" }
#         patch user_address_path(admin), params: { address: new_attributes }
#         address.reload
# 
#         expect(address.street).to eq("Updated Street Name")
#         expect(response).to redirect_to(user_path(admin))
#       end
#     end
# 
#     context "with invalid parameters" do
#       it "does not update the address and re-renders the edit template" do
#         invalid_attributes = { street: nil }
#         patch user_address_path(admin), params: { address: invalid_attributes }
#         address.reload
# 
#         expect(response).to have_http_status(:unprocessable_entity).or have_http_status(:ok)
#       end
#     end
#   end
# end
