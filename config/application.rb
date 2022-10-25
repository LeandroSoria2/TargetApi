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
    config.action_mailer.smtp_settings = {
      address: 'smtp.sendgrid.net',
      port: 587,
      domain: ENV.fetch('SERVER_URL', nil),
      authentication: :plain,
      user_name: 'apikey',
      password: ENV.fetch('SENDGRID_API_KEY', nil)
    }

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = { host: ENV.fetch('SERVER_URL', nil) }
    config.action_mailer.default_options = {
      from: ENV.fetch('SENDGRID_SENDER_EMAIL')
    }
  end
end
