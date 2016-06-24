module Middleware
  class Errors < Faraday::Middleware
    def call(request_env)
      @app.call(request_env).on_complete do |response_env|
        code = response_env[:status]
        fail_with_error_details(response_env, Cb::ServiceUnavailableError) if code == 503 || simulate_auth_outage?
        fail_with_error_details(response_env, Cb::UnauthorizedError) if [401, 403].include?(code)
        fail_with_error_details(response_env, Cb::DocumentNotFoundError) if code == 404
        fail_with_error_details(response_env, Cb::BadRequestError) if code && code >= 400 && code < 500
        fail_with_error_details(response_env, Cb::ServerError) if code && code >= 500
      end
    end

    private

    def fail_with_error_details(response, error_type)
      processed_response = response.body
      error = error_type.new(error_message(processed_response))
      error.code = response.status rescue nil
      error.raw_response = response
      error.response = processed_response
      fail error
    end

    def simulate_auth_outage?
      ENV['SIMULATE_AUTH_OUTAGE'].to_s.downcase == 'true'
    end

    def error_message(processed_response)
      processed_response.fetch('errors', processed_response.fetch('Errors', ''))
    end
  end
end
