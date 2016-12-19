Rails.application.routes.draw do

  root :to => 'main#index'

  namespace :api do
    resources :users
    resources :locations
    resources :bookings
    resources :drivers
  end

  post 'api/users/logout', to: 'api/users#logout'
  post 'api/users/login', to: 'api/users#login'
  post 'api/users/status', to: 'api/users#status'
  post 'api/bookings/accept', to: 'api/bookings#accept'
  post 'api/bookings/reject', to: 'api/bookings#reject'
  post 'api/bookings/invoice', to: 'api/bookings#invoice'
  post 'api/bookings/all_invoice', to: 'api/bookings#all_invoice'
  post 'api/bookings/start_ride', to: 'api/bookings#start_ride'
  post 'api/bookings/end_ride', to: 'api/bookings#end_ride'
  post 'api/drivers/location_set', to: 'api/drivers#location_set'
  post 'api/drivers/login', to: 'api/drivers#login'
  post 'api/drivers/logout', to: 'api/drivers#logout'
  post 'api/drivers/status', to: 'api/drivers#status'
  post 'api/drivers/set_location', to: 'api/drivers#location_set'
  put 'api/drivers', to: 'api/drivers#update'
end
