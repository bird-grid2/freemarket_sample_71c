Rails.application.routes.draw do
  devise_for :users
  root 'orders#index'

 resources :items, only: [ :show , :new ]
 resources :users, only: [ :index, :edit, :update, :show ]
 resources :orders, only: [ :index]
 resources :shipping_addresses, only: [ :index]
 resources :cards, only: [ :show , :new ] do
  collection do
    post 'show', to: 'card#show'
    post 'pay', to: 'card#pay'
    post 'delete', to: 'card#delete'
  end
 end
end