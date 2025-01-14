Rails.application.routes.draw do
  get "orders/new"
  get "orders/create"
  get "orders/show"
  devise_for :users
  root "products#index"
  resources :categories
  resources :products

  resource :cart, only: [ :show ]
  resources :cart_items, only: [ :create, :update, :destroy ]

  resources :orders, only: [ :new, :create, :show ]

  resources :users, only: [ :index ] do
    patch :update_role, on: :member
  end
end
