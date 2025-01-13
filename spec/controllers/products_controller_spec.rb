require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:category) { create(:category) }
  let(:valid_attributes) { attributes_for(:category) }
  let(:invalid_attributes) { attributes_for(:category, name: nil) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: category.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: category.id }
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

      it 'redirects to the created category' do
        post :create, params: { category: valid_attributes }
        expect(response).to redirect_to(Category.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect {
          post :create, params: { category: invalid_attributes }
        }.not_to change(Category, :count)
      end

      it 'renders the new template' do
        post :create, params: { category: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { name: 'Updated Category' } }

      it 'updates the requested category' do
        patch :update, params: { id: category.id, category: new_attributes }
        category.reload
        expect(category.name).to eq('Updated Category')
      end

      it 'redirects to the category' do
        patch :update, params: { id: category.id, category: new_attributes }
        expect(response).to redirect_to(category)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the category' do
        patch :update, params: { id: category.id, category: invalid_attributes }
        category.reload
        expect(category.name).not_to be_nil
      end

      it 'renders the edit template' do
        patch :update, params: { id: category.id, category: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested category' do
      category
      expect {
        delete :destroy, params: { id: category.id }
      }.to change(Category, :count).by(-1)
    end

    it 'redirects to the categories list' do
      delete :destroy, params: { id: category.id }
      expect(response).to redirect_to(categories_url)
    end
  end
end
