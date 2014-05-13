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
        raise NotImplemented
      end

      def set_http_method
        raise NotImplemented
      end

      def set_response_object
        raise NotImplemented
      end

      def set_query(args)
        raise NotImplemented
      end

      def set_headers(args)
        raise NotImplemented
      end

      def set_body(args)
        raise NotImplemented
      end
    end
  end
end