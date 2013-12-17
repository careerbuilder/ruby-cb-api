module Cb
  module Responses

    class Metadata
      attr_reader :errors, :timing

      def initialize(raw_response_hash, raise_on_timing_missing = true)
        @response     = raw_response_hash
        @should_raise = raise_on_timing_missing
        @errors       = parsed_errors
        @timing       = parsed_timing_info
      end

      private
      attr_reader :response, :should_raise

      def parsed_errors
        Errors.new(response)
      end

      def parsed_timing_info
        Timing.new(response, should_raise)
      end
    end

  end
end
