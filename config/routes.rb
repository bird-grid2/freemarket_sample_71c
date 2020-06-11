Rails.application.routes.draw do
  devise_for :users
  root 'orders#index'

 resources :items, only: [ :show , :new ]
 resources :users, only: [ :index, :edit, :update, :show ]
 resources :orders, only: [ :index] do
  collection do
    get 'confirm', to: 'orders#confirm'
    post 'pay', to: 'orders#pay'
    get 'done', to: 'orders#done'
  end
 end
 resources :shipping_addresses, only: [ :index]
 resources :cards, only: [ :show , :new ] do
  collection do
    post 'show', to: 'cards#show'
    post 'pay', to: 'cards#pay'
    post 'delete', to: 'cards#delete'
  end
 end
end