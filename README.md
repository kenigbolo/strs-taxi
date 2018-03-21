# DEVELOPERS GUIDE

## Getting Started

+ Clone the repo:
`clone git@bitbucket.org:strs_taxi/strs-taxi.git` for SSH
`git clone https://expensivestephen@bitbucket.org/strs_taxi/strs-taxi.git` for HTTPS

## Dependencies

* Ruby version 2.2.1 and above
* Rails 5.0.0
* CodeShip

Once you have those two, you can then run your command line and navigate into the project's folder and then run:

* Run `bundle install` to install all other dependencies


    ***Note*** some gems might cause issues while installing, so for unix/linux users try `sudo gem install <gem_name>`
* Run `rails db:migrate` or `rake db:migrate`
* Run `rails db:seed`  or `rake db:seed` to seed the `db` if neccessary.

(*the `rake` command was used for rails version prior rails 5. But it is no logner required*)

## Running The Server

You can run `rails s` or `rails server` and visit the page on the browser by typing `localhost:3000`. (*you can add the flag `-p <port_number>` to specify a different port number, e.i. `rails s -p 8000`*)

##Running The Specs
After all the setting up as mentioned above, you can run the tests. The tests are driven by rspec. You can get them fired up by running the following command from the terminal.

  `rspec spec`

or

  `bundle exec rspec`


## Code Coverage
Currently at 90% with simplecov. To generate coverage report:
* Add `gem 'simplecov', require: false` to `test` group in Gemfile and `bundle install`.
* Add the line
      `require 'simplecov'
      SimpleCov.start`
to the top of `spec_helper.rb`
* Add the line
      `if ENV['RAILS_ENV'] == 'test'
        require 'simplecov'
        SimpleCov.start 'rails'
        puts "required simplecov"
      end`
to the top of the `bin/rails` file
* Run `rspec spec` and visit the `coverage/index.html` to view the coverage report.

## API Main Features

* Authentication (Token Based Authentication)
* Registration
* Taxi request & response
* Payment Management
* Admin Interface

## API Routes

```ruby
Prefix Verb   URI Pattern                  Controller#Action
root                    GET    /                                  main#index
api_users               GET    /api/users(.:format)               api/users#index
                        POST   /api/users(.:format)               api/users#create
api_user                GET    /api/users/:id(.:format)           api/users#show
                        PATCH  /api/users/:id(.:format)           api/users#update
                        PUT    /api/users/:id(.:format)           api/users#update
                        DELETE /api/users/:id(.:format)           api/users#destroy
api_locations           GET    /api/locations(.:format)           api/locations#index
                        POST   /api/locations(.:format)           api/locations#create
api_location            GET    /api/locations/:id(.:format)       api/locations#show
                        PATCH  /api/locations/:id(.:format)       api/locations#update
                        PUT    /api/locations/:id(.:format)       api/locations#update
                        DELETE /api/locations/:id(.:format)       api/locations#destroy
api_users_login         POST   /api/users/login(.:format)         api/users#login
                        POST   /api/bookings(.:format)            api/bookings#create
api_booking             GET    /api/bookings/:id(.:format)        api/bookings#show
                        PATCH  /api/bookings/:id(.:format)        api/bookings#update
                        PUT    /api/bookings/:id(.:format)        api/bookings#update
                        DELETE /api/bookings/:id(.:format)        api/bookings#destroy
api_users_logout        GET    /api/users/logout(.:format)        api/users#logout
api_users_status        POST   /api/users/status(.:format)        api/users#status
api_bookings_accept     POST   /api/bookings/accept(.:format)     api/bookings#accept
api_bookings_start_ride POST   /api/bookings/start_ride(.:format) api/bookings#start_ride
api_bookings_end_ride   POST   /api/bookings/end_ride(.:format)   api/bookings#end_ride

```

## Database
* Development Environment
    Uses Sqlite
* Production && Staging environment
    Uses Postgres
