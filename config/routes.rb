Rails.application.routes.draw do
 root 'items#index'

 resources :items, only: [ :index, :show , :new ]
 resources :users, only: [ :index, :edit, :update, :show ]

end

