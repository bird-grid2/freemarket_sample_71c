Rails.application.routes.draw do
 root 'orders#index'

 resources :items, only: [ :index, :show , :new ]
 resources :users, only: [ :index, :edit, :update, :show ]
 resources :orders, only: [ :index]
 resources :shipping_addresses, only: [ :index]

end

