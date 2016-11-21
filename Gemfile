source 'https://rubygems.org'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'sqlite3'
gem 'puma', '~> 3.0'
gem 'active_model_serializers'
gem 'rack-cors'
gem 'pusher', '~> 1.3'
gem 'bcrypt', '~> 3.1'
gem 'rack-attack'
group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
end
group :production do
  gem 'pg', '0.18.1'
  gem 'rails_12factor'
end
group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'capybara'
  gem 'faker', '~> 1.6'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'poltergeist'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
