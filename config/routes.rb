Rails.application.routes.draw do
  root :to => 'locations#index'
  resources :locations
  namespace :api do
    resources :users    
  end

  post 'api/users/login', to: 'api/users#login'
end
