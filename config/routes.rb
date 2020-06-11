Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

 resources :items, only: [ :show , :new, :destroy, :edit, :update ]
 resources :users, only: [ :index, :edit, :update, :show]

end