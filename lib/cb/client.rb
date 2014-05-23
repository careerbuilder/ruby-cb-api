module Cb
  class Client
    attr_reader :callback_block

    def initialize(&block)
      @callback_block = block
    end

    def execute(request)
      api_response = call_api(request)
      response_class = Cb::Utils::ResponseMap.response_for(request.class)
      response_class.new api_response
    end

    private

    def call_api(request)
      api_wrapper.execute_http_request(
        request.http_method,
        request.endpoint_uri,
        {
          query: request.query,
          headers: request.headers,
          body: request.body
        },
        &@callback_block)
    end

    def api_wrapper
      Cb::Utils::Api.instance
    end
  end
end
