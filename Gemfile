# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.2', '>= 7.0.2.4'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false
gem 'byebug', '~> 11.1', '>= 11.1.3'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'devise_token_auth', '>= 1.2.0', git: 'https://github.com/lynndylanhurley/devise_token_auth'
gem 'rack-cors', '~> 1.1', '>= 1.1.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.21'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'annotate', '~> 3.2'
  gem 'rubocop-rails', '~> 2.15'
  gem 'rubocop-rootstrap', '~> 1.2'
  gem 'web-console'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.1'
  gem 'webdrivers'
end
