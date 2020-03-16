source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2'

# Use Puma as the app server
gem 'puma', '~> 4.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.1'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1'

# Use Capistrano for deployment
gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', :require => 'rack/cors'

# Pusher notification engine
gem 'pusher', '~> 1.3'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 1.1.0', group: :doc
gem 'active_model_serializers'
gem 'httparty'
gem 'rack-attack'
gem 'figaro'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'rails-controller-testing'
end

group :development do
  gem 'listen', '~> 3.2.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'cucumber-rails-training-wheels'
  gem 'simplecov', :require => false
  gem 'database_cleaner'
  gem 'capybara'
  gem 'faker', '~> 2.10'
  gem 'launchy'
  gem 'poltergeist'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
