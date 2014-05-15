module Cb
  module Requests
    class Base
      attr_reader :body, :headers, :query, :uri_endpoint, :http_method, :response_object

      def initialize(args)
        @uri_endpoint = set_uri_endpoint
        @http_method = set_http_method
        @response_object = set_response_object

        @query = set_query(args)
        @headers = set_headers(args)
        @body = set_body(args)
      end

      private

      def set_uri_endpoint
        raise NotImplementedError "set_uri_endpoint not implemented"
      end

      def set_http_method
        raise NotImplementedError "set_http_method not implemented"
      end

      def set_response_object
        raise NotImplementedError "set_response_body not implemented"
      end

      def set_query(args)
        raise NotImplementedError "set_query not implemented"
      end

      def set_headers(args)
        raise NotImplementedError "set_headers not implemented"
      end

      def set_body(args)
        raise NotImplementedError "set_body not implemented"
      end

      private

      def NotImplementedError(message)
        Cb::Requests::NotImplementedError.new(message)
      end
    end

    class NotImplementedError < StandardError
      def initialize(message = "Method not implemented")
        super
      end
    end
  end
end