source 'https://rubygems.org'

ruby File.read('.tool-versions').split[1]

gem 'rails', '6.0.3.4'

gem 'pg'
gem 'puma'

gem 'coffee-rails'
gem 'decent_exposure'
gem 'devise'
gem 'haml-rails'
gem 'honeybadger'
gem 'jbuilder'
gem 'jquery-rails'
gem 'sass-rails'
gem 'uglifier'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'listen'
  gem 'rails-erd'
  gem 'web-console'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_bot_rails', '4.8.2'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop-rails'
  gem 'webdrivers'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webmock'
end
