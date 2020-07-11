Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  root 'items#index'

  resources :items do
    resources :comments, only: :create
    resources :likes, only: [ :create, :destroy]
    member do
      get :purchase
      get :confirm
      post :pay
      get :done
    end
    collection do
      get 'category/get_children_categories', to: 'items#get_children_categories', defaults: { format: 'json' }
      get 'category/get_grandchildren_categories', to: 'items#get_grandchildren_categories', defaults: { format: 'json' }
      get 'search'
    end
  end

  resources :users, only: [ :index, :show] do
    resources :likes, only: :index
    member do
      get :notification
      get :todo
      get :in_progress
      get :completed
      get :purchase
      get :purchased
      get :log_out
    end
  end
  
 resources :shipping_addresses, only: [ :index]
  
 resources :cards, only: [ :show , :new, :delete ] do	
  collection do
    post 'show', to: 'cards#show'	
    post 'pay', to: 'cards#pay'	
    get 'delete', to: 'cards#delete'
  end
 end
end
