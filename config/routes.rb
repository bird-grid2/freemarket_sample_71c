Rails.application.routes.draw do
  get 'addresses/index'
  get 'orders/index'
 root 'orders#index'

 resources :items, only: [ :index, :show , :new ]
 resources :users, only: [ :index, :edit, :update, :show ]
 resources :orders, only: [ :index]
end

