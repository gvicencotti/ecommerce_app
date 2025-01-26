Rails.application.routes.draw do
  devise_for :users
  root "products#index"

  resources :categories
  resources :products
  resources :orders, only: [ :index, :new, :create, :show ]
  resources :cart_items, only: [ :create, :update, :destroy ]

  resource :cart, only: [ :show ] do
    post "add_product/:product_id", to: "carts#add_product", as: "add_product"
  end

  resources :users, only: [ :index, :show, :edit, :update ] do
    patch :update_role, on: :member
    resource :address, only: [ :new, :create, :edit, :update ]
  end

  post "checkout/create", to: "checkout#create", as: "checkout_create"
  get "checkout/confirm_address", to: "checkout#confirm_address", as: "confirm_address_checkout"
  get "checkout/success", to: "checkout#success", as: "checkout_success"
  get "checkout/cancel", to: "checkout#cancel", as: "checkout_cancel"
end
