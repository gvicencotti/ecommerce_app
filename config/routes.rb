Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :categories
  resources :products
end
