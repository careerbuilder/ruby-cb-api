require 'support/mocks/response'

module Mocks
  class RequestTest
    attr_reader :body, :headers, :query, :uri_endpoint, :http_method, :response_object

    def initialize(arg)
      @http_method = arg
      @uri_endpoint = "parts unknown"
      @response_object = ResponseTest
    end
  end
end
