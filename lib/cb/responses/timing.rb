module Cb
  module Responses

    class Timing
      attr_reader :response_sent, :elapsed

      def initialize(response, raise_on_parse_fail = true)
        @response = response
        @should_raise_on_parse_fail = raise_on_parse_fail
        post_initialize
      end

      private
      attr_reader :response, :should_raise_on_parse_fail

      def post_initialize
        raise_on_empty_timing_info
        @response_sent = parsed_response_sent
        @elapsed       = parsed_time_elapsed
      end

      def raise_on_empty_timing_info
        should_raise = (response.nil? || !response.respond_to?(:[])) && should_raise_on_parse_fail
        raise ExpectedResponseFieldMissing.new('Missing/malformed timing info!') if should_raise
      end

      def parsed_response_sent
        DateTime.parse(response['TimeResponseSent']) rescue nil
      end

      def parsed_time_elapsed
        begin
          response.include?('TimeElapsed') ? response['TimeElapsed'].to_f : nil
        rescue
          nil
        end
      end
    end

  end
end
