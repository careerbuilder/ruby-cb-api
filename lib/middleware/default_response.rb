require 'faraday'

module Middleware
  class DefaultResponse < Faraday::Middleware
    def call(request_env)
      @app.call(request_env).on_complete do |response_env|
        if response_env.body.nil?
          response_env.body = {}
        end
      end
    end
  end
end
