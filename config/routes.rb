Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

  resources :items, only: [ :show , :new, :create, :update] do
    collection do
      get 'category/get_children_categories', to: 'items#get_children_categories', defaults: { format: 'json' }
      get 'category/get_grandchildren_categories', to: 'items#get_grandchildren_categories', defaults: { format: 'json' }
    end
  end
  resources :users, only: [ :index, :edit, :update, :show]
  resources :shipping_addresses, only: [ :index]

end