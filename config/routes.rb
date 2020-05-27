Rails.application.routes.draw do
  root 'purchases#index'
  resources :purchases
  resources :addresses
  get 'purchases/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
