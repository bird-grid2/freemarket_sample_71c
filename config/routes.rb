Rails.application.routes.draw do
  #devise_for :users, controllers: {
    #omniauth_callbacks: 'users/omniauth_callbacks',
    #registrations: 'users/registrations'
  #}
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'

  resources :items do
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

  resources :items, except: [:edit, :destroy] do
    resources :comments, only: :create
    resources :likes, only: [ :create, :destroy]
    
    collection do
      get 'category/get_children_categories', to: 'items#get_children_categories', defaults: { format: 'json' }
      get 'category/get_grandchildren_categories', to: 'items#get_grandchildren_categories', defaults: { format: 'json' }
      get 'get_shipping_method'
      get 'search'
    end
  end

  resources :users, except: [ :new, :create, :destroy] do
    resources :likes, only: :index
  end
  
  resources :shipping_addresses, only: [ :index]

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
