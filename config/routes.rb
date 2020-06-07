Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

  resources :orders, only: [ :index]
  resources :shipping_addresses, only: [ :index]
  resources :items, only: [ :show , :new, :create] do
    collection do
      get 'category/get_children_categories', to: 'items#get_children_categories', defaults: { format: 'json' }
      get 'category/get_grandchildren_categories', to: 'items#get_grandchildren_categories', defaults: { format: 'json' }
    end
    member do
      get :detail
    end
  end

  resources :users, only: [ :index, :edit, :update, :show ] do
    member do
      get :notifictaion
      get :todo
      get :like
      get :in_progress
      get :completed
      get :purchase
      get :purchased
      get :log_out
    end
  end
 
end