Rails.application.routes.draw do
  namespace :api do
    resources :users
  end

  post 'api/users/login', to: 'users#login'
end
