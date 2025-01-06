require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:valid_attributes) { { name: 'Electronics' } }
  let(:invalid_attributes) { { name: nil } }

  describe 'GET #index' do
    it 'returns a success response' do
      Category.create!(valid_attributes)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      category = Category.create!(valid_attributes)
      get :show, params: { id: category.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect {
          post :create, params: { category: valid_attributes }
        }.to change(Category, :count).by(1)
      end
    end
  end

  it 'redirects to the created category' do
    post :create, params: { category: valid_attributes }
    expect(response).to redirect_to(Category.last)
  end

  context 'with invalid parameters' do
    it 'does not create a new Category' do
      expect {
        post :create, params: { category: invalid_attributes }
      }.not_to change(Category, :count)
    end
  end

  it 'renders the new template' do
    post :create, params: { category: invalid_attributes }
    expect(response).to render_template(:new)
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested category' do
      category = Category.create!(valid_attributes)
      expect {
        delete :destroy, params: { id: category.to_param }
      }.to change(Category, :count).by(-1)
    end
  end

  it 'redirects to the categories list' do
    category = Category.create!(valid_attributes)
    delete :destroy, params: { id: category.to_param }
    expect(response).to redirect_to(categories_url)
  end
end
