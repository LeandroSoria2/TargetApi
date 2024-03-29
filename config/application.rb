require_relative 'boot'

require 'rails/all'

require 'active_storage/engine'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TargetApi
  class Application < Rails::Application
    config.load_defaults 7.0
    config.add_autoload_paths_to_load_path = false
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
