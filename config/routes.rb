Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

  resources :users, only: [ :index, :edit, :update, :show ]
  resources :items, only: [ :show , :new ]
 
  resources :orders, only: [ :index]
  resources :shipping_addresses, only: [ :index]

end