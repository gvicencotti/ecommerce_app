Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :categories
  resources :products

  resources :users, only: [ :index ] do
    patch :update_role, on: :member
  end
end
