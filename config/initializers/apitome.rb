if Rails.env.development?
  Apitome.configure do |config|
    config.mount_at = '/api/docs'
    config.root = nil
    config.doc_path = 'doc/api'
    config.parent_controller = 'ActionController::Base'
    config.title = 'Target API Documentation'
    config.layout = 'apitome/application'
    config.code_theme = 'default'
    config.css_override = nil
    config.js_override = nil
    config.readme = '../api.md'
    config.single_page = true
    config.url_formatter = ->(str) { str.gsub(/\.json$/, '').underscore.gsub(/[^[:word:]]/, '-') }
    config.remote_url = nil
    config.http_basic_authentication = nil
    config.precompile_assets = true
    config.simulated_response = true
  end
end
