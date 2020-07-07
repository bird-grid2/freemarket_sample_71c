Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'

  resources :items, only: [ :show , :new] do
    member do
      get :purchase
      get :confirm
      post :pay
      get :done
    end

    collection do
      get 'category/get_children_categories', to: 'items#get_children_categories', defaults: { format: 'json' }
      get 'category/get_grandchildren_categories', to: 'items#get_grandchildren_categories', defaults: { format: 'json' }
    end
  end

 resources :users, only: [ :index, :edit, :show]

  root 'items#index'

  resources :items, only: [ :show , :new, :create] do
    collection do
      get 'category/get_children_categories', to: 'items#get_children_categories', defaults: { format: 'json' }
      get 'category/get_grandchildren_categories', to: 'items#get_grandchildren_categories', defaults: { format: 'json' }
      get 'search'
    end
    resources :likes, only: [ :create, :destroy]
  end

  resources :users, except: [ :new, :create, :destroy] do
    resources :likes, only: :index
  end

 resources :orders, only: [ :index]
 resources :shipping_addresses, only: [ :index]
 resources :cards, only: [ :show , :new, :delete ] do	
  collection do
    post 'show', to: 'cards#show'	
    post 'pay', to: 'cards#pay'	
    get 'delete', to: 'cards#delete'
  end
 end

end