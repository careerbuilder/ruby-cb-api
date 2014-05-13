module Cb
  class Client
    attr_reader :callback_method, :returned_callback_value

    def initialize(callback_method = method(:default_callback_method))
      raise NotAMethodError unless callback_method.class == Method
      @callback_method = callback_method
    end

    def default_callback_method(arg)
      @returned_callback_value = arg
    end

    def make_request(request)
      api_response = call_api(request)
      request.response_object.new api_response
    end

    private

    def call_api(request)
      cb_client.method(:"cb_#{request.http_method}").call(
          request.uri_endpoint,
          {
              query: request.query,
              headers: request.headers,
              body: request.body
          },
          @callback_method)
    end

    def cb_client
      Cb::Utils::Api.instance
    end
  end
end