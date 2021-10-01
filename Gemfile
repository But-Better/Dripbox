# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

## Style
# Bootstrap
# https://getbootstrap.com/
gem 'bootstrap', '~> 5.0.0'

## Performence
# bullet

# https://github.com/flyerhzm/bullet
gem 'bullet', group: 'development'

# server timing
# https://github.com/scoutapp/ruby_server_timing
gem 'server_timing'

## Security
# Brakeman
# https://brakemanscanner.org/docs/introduction/
gem 'brakeman'

# rspec-rails
# https://github.com/rspec/rspec-rails
gem 'rspec-rails'

# rails-controller-testing gem
# https://github.com/rails/rails-controller-testing
gem 'rails-controller-testing'

# image processing for storage_blob
gem 'image_processing', '~> 1.2'

## Source code
# Rubocop
# https://github.com/rubocop/rubocop
gem 'rubocop', require: false

# simplecov
# https://github.com/simplecov-ruby/simplecov
gem 'simplecov', require: false, group: :test

# azure storage support
# https://github.com/Azure/azure-storage-ruby
gem 'azure-storage-blob', require: false, group: :production

# Minitests
gem 'minitest', '~> 5.14', '>= 5.14.4'

# rouge one
# https://github.com/rubocop/ruby-style-guide
gem 'rouge'

# graphing tool
# https://github.com/dgilperez/metrics-graphics-rails
gem 'metrics-graphics-rails'

# gon variable pipeline
# https://github.com/gazay/gon
gem 'gon'

# faker data generator
# https://github.com/faker-ruby/faker
gem 'faker'

# Rails 4+ Asset Pipeline on Heroku
# gem 'rails_serve_static_assets', group: :production

## Default
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
# Use PostgreSQL  as the database for Active Record
gem 'pg', '~> 1.2', '>= 1.2.3'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
