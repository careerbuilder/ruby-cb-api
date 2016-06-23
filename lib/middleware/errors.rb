module Middleware
  class Errors < Faraday::Middleware
    def call(request_env)
      @app.call(request_env).on_complete do |response_env|
        code = response_env[:status]
        fail_with_error_details(response, Cb::ServiceUnavailableError) if code == 503 || simulate_auth_outage?
        fail_with_error_details(response, Cb::UnauthorizedError) if [401, 403].include?(code)
        fail_with_error_details(response, Cb::DocumentNotFoundError) if code == 404
        fail_with_error_details(response, Cb::BadRequestError) if code && code >= 400 && code < 500
        fail_with_error_details(response, Cb::ServerError) if code && code >= 500
      end
    end

    private

    def fail_with_error_details(response, error_type)
      processed_response = process_response_body(response)
      error = error_type.new(error_message(processed_response))
      error.code = response.code rescue nil
      error.raw_response = response
      error.response = processed_response
      fail error
    end

    def simulate_auth_outage?
      ENV['SIMULATE_AUTH_OUTAGE'].to_s.downcase == 'true'
    end
  end
end
