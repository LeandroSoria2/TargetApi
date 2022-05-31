# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'support/factory_bot'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

end
