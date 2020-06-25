Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'

  resources :items, only: [ :show , :new, :create] do
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

 resources :users, only: [ :index, :edit, :update, :show]
 resources :shipping_addresses, only: [ :index]
 resources :cards, only: [ :show , :new, :delete ] do	
  collection do	
    post 'show', to: 'cards#show'	
    post 'pay', to: 'cards#pay'	
    post 'delete', to: 'cards#delete'	
    post 'done', to: 'cards#done'
  end
 end

end