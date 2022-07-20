require 'factory_bot_rails'
require 'helpers'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Helpers

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.order = 'random'

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
