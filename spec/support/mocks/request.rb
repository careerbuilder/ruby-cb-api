require 'support/mocks/response'

module Mocks
  class Request

    def initialize(arg)
      @arg = arg
    end

    def base_uri
      'www.example.com'
    end

    def body
      nil
    end

    def headers
      nil
    end

    def query
      nil
    end

    def endpoint_uri
      "parts unknown"
    end

    def http_method
      @arg
    end
  end
end
