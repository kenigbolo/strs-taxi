Rails.application.routes.draw do

  root :to => 'main#index'

  namespace :api do
    resources :users
    resources :locations
  end

  post 'api/users/login', to: 'api/users#login'
end
