Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

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

  resources :items, only: [ :show , :new, :destroy ] 
  resources :orders, only: [ :index]
  resources :shipping_addresses, only: [ :index]

end