require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:category) { create(:category) }
  let(:valid_attributes) { attributes_for(:product).merge(category_id: category.id) }
  let(:invalid_attributes) { attributes_for(:product, name: nil, price: nil, stock: nil) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'returns a success response' do
      create(:product)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Product' do
        expect {
          post :create, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a product' do
        expect {
          post :create, params: { product: invalid_attributes }
        }.not_to change(Product, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested product' do
      product = create(:product)
      expect {
        delete :destroy, params: { id: product.to_param }
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to the products list' do
      product = create(:product)
      delete :destroy, params: { id: product.to_param }
      expect(response).to redirect_to(products_url)
    end
  end
end
