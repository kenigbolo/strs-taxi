# DEVELOPERS GUIDE

##Getting Started

+ Clone the application (API) with `git clone https://bitbucket.org:expensivestephen/strs-taxi.git` or use ssh  `git clone git@bitbucket.org:expensivestephen/strs-taxi.git`.

##Dependencies

* Ruby version 2.2.1 and above
* rails 5.0.0

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

##API Main Features

* Authentication (Token Based Authentication)
* Registration
* Taxi request & response
* Payment Management
* Admin Interface

##Database
* Development Environment
    Uses Sqlite
* Production && Staging environment
    Uses Postgres