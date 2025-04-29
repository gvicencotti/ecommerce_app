# #Testes serão ajustados posteriormente
# 
# #require 'rails_helper'
# # 
# # RSpec.describe "Orders", type: :request do
# #   let(:user) { create(:user) }
# # 
# #   before do
# #     sign_in user
# #     puts "User authenticated: #{user.id}"
# #     user.create_cart
# #     product = create(:product, price: 100)
# #     create(:cart_item, cart: user.cart, product: product, quantity: 2)
# #   end
# # 
# #   describe "GET /new" do
# #     it "returns http success" do
# #       get new_order_path
# #       expect(response).to have_http_status(:success)
# #     end
# #   end
# # 
# #   describe "POST /create" do
# #     it "creates an order and redirects" do
# #       post orders_path, params: {
# #         order: {
# #           address: "123 Main St",
# #           payment_method: "Credit Card"
# #         }
# #       }
# # 
# #       expect(response).to have_http_status(:redirect)
# #       follow_redirect!
# #       expect(response).to have_http_status(:success)
# #       expect(response.body).to include("Order was successfully created")
# #     end
# #   end
# # 
# #   describe "GET /show" do
# #     it "returns http success" do
# #       order = user.orders.create!(
# #         address: "123 Rua",
# #         payment_method: "Pix",
# #         total_price: 100
# #       )
# # 
# #       get order_path(order)
# #       expect(response).to have_http_status(:success)
# #     end
# #   end
# # end
