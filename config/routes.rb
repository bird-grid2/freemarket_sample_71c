Rails.application.routes.draw do

  get 'items/show'


  root "items#index"

end
