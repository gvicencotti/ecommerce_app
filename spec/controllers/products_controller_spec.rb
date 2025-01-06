require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:category) { create(:category) }
  let(:valid_attributes) { attributes_for(:product).merge(category_id: category.id) }
  let(:invalid_attributes) { attributes_for(:product, name: nil, price: nil, stock: nil) }

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
end
