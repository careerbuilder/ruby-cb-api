module Cb
  module Responses

    class Metadata
      attr_reader :errors, :timing

      def initialize(raw_response_hash)
        @response = raw_response_hash
        @errors   = parsed_errors
        @timing   = parsed_timing_info
      end

      private
      attr_reader :response

      def parsed_errors
        Errors.new(response)
      end

      def parsed_timing_info
        Timing.new(response)
      end
    end

  end
end
