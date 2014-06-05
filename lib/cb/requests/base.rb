module Cb
  module Requests
    class Base

      attr_reader :args

      def initialize(argument_hash)
        raise ArgumentError.new("#{argument_hash.class} is not a Hash") unless argument_hash.is_a?(Hash)
        @args = argument_hash
      end

      def endpoint_uri
        raise NotImplementedError.new __method__
      end

      def http_method
        raise NotImplementedError.new __method__
      end

      def query
        nil
      end

      def headers
        nil
      end

      def body
        nil
      end

      private

      def test?
        (args[:test] || Cb.configuration.test_resources).to_s
      end

    end
  end
end
