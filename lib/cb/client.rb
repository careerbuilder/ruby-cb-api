module Cb
  class Client
    attr_accessor :callback_method, :returned_callback_value

    def initialize(callback_method = method(:default_callback_method))
      @callback_method = callback_method
    end

    def default_callback_method(arg)
      @returned_callback_value = arg
    end

    def make_call(criteria)
      api_response = call_api(criteria)
      criteria.response_object.new api_response
    end

    private

    def call_api(criteria)
      cb_client.method(:"cb_#{criteria.http_method}").call(
          criteria.uri_endpoint,
          {
              query: criteria.query,
              headers: criteria.headers,
              body: criteria.body
          },
          @callback_method)
    end

    def cb_client
      Cb::Utils::Api.instance
    end
  end
end