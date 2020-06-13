Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'

 resources :items, only: [ :show , :new, :destroy, :edit, :update ]

  resources :items, only: [ :show , :new, :create] do
    collection do
      get 'category/get_children_categories', to: 'items#get_children_categories', defaults: { format: 'json' }
      get 'category/get_grandchildren_categories', to: 'items#get_grandchildren_categories', defaults: { format: 'json' }
    end
  end

 resources :users, only: [ :index, :edit, :update, :show]
 resources :orders, only: [ :index]
 resources :shipping_addresses, only: [ :index]

end