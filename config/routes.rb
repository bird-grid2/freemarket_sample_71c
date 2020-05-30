Rails.application.routes.draw do
 devise_for :users
 root "items#index"

 resources :users, only: [ :index, :edit, :update, :show ]

  
end
