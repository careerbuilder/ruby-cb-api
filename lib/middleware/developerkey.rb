require 'faraday'

module Middleware
  class Developerkey < Faraday::Middleware
    def call(request_env)
      request_env.fetch(:request_headers, {}).merge!({ 'Developerkey' => Cb.configuration.dev_key })
      @app.call(request_env)
    end
  end
end
