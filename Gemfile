# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'
gem 'activeadmin', '~> 2.13', '>= 2.13.1'
gem 'bootsnap', require: false
gem 'byebug', '~> 11.1', '>= 11.1.3'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'devise_token_auth', '>= 1.2.0', git: 'https://github.com/lynndylanhurley/devise_token_auth'
gem 'geokit-rails', '~> 2.2'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors', '~> 1.1', '>= 1.1.1'
gem 'rails', '~> 7.0.2', '>= 7.0.2.4'
gem 'sass-rails', '~> 6.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.21'
  gem 'rspec_api_documentation'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
  gem 'sendgrid-ruby'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'annotate', '~> 3.2'
  gem 'apitome', '~> 0.3.1'
  gem 'brakeman', '~> 5.2', '>= 5.2.3'
  gem 'rails_best_practices', '~> 1.23', '>= 1.23.1'
  gem 'reek', '~> 6.1', '>= 6.1.1'
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

group :production do
  gem 'aws-sdk-s3', require: false
end
