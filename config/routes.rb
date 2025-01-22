Rails.application.routes.draw do
  devise_for :users
  root "products#index"

  resources :categories
  resources :products

  resource :cart, only: [ :show ] do
    post "add_product/:product_id", to: "carts#add_product", as: "add_product"
  end

  resources :cart_items, only: [ :create, :update, :destroy ]

  resources :orders, only: [ :new, :create, :show ]

  resources :users, only: [ :index, :show, :edit, :update ] do
    patch :update_role, on: :member
    resource :address, only: [ :new, :create, :edit, :update ]
  end

  post "checkout/create", to: "checkout#create", as: "checkout_create"
  get "checkout/success", to: "checkout#success", as: "checkout_success"
  get "checkout/cancel", to: "checkout#cancel", as: "checkout_cancel"
end
