Rails.application.routes.draw do

  root :to => 'main#index'

  namespace :api do
    resources :users
    resources :locations
  end
  
  get 'api/users/logout', to: 'api/users#logout'
  post 'api/users/login', to: 'api/users#login'
  post 'api/users/status', to: 'api/users#status'
end
