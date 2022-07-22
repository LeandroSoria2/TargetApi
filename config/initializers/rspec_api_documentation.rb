unless Rails.env.production?
  module RspecApiDocumentation
    class RackTestClient < ClientBase
      def response_body
        last_response.body.encode('utf-8')
      end
    end
  end

  RspecApiDocumentation.configure do |config|
    config.format = %i[api_blueprint json]

    config.request_headers_to_include = %w[access-token uid client]
    config.response_headers_to_include = %w[access-token expiry token-type uid client]

    config.api_name = 'Target API'

    config.request_body_formatter = :json
  end
end
