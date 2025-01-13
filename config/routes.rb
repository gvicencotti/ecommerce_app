Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :categories
  resources :products

  resource :cart, only: [ :show ]
  resources :cart_items, only: [ :create, :update, :destroy ]

  resources :users, only: [ :index ] do
    patch :update_role, on: :member
  end
end
