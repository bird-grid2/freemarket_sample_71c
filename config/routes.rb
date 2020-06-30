Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'items#index'

  resources :orders, only: [ :index]
  resources :shipping_addresses, only: [ :index]
  resources :items, only: [ :show, :new, :create, :edit, :update], shallow: true do
    collection do
      get 'category/get_children_categories', to: 'items#get_children_categories', defaults: { format: 'json' }
      get 'category/get_grandchildren_categories', to: 'items#get_grandchildren_categories', defaults: { format: 'json' }
    end
    resources :item_images, except: [ :show, :index]
  end
    resources :likes, only: [ :create, :destroy]
  end

  resources :users, except: [ :new, :create, :destroy] do
    resources :likes, only: :index
    member do
      get :notification
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