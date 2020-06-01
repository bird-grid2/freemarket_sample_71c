Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

 resources :items, only: [ :show , :new ]
 resources :users, only: [ :index, :edit, :update, :show ]
 resources :orders, only: [ :index]
 resources :shipping_addresses, only: [ :index]

end