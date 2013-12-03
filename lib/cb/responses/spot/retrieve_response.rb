module Cb
  module Responses

    class ApiResponse
      attr_reader :metadata, :models

      def initialize(raw_response_hash)
       @response = raw_response_hash
       @metadata = extract_metadata
       @models   = extract_models
      end

      protected

      def extract_models
       raise NotImplementedError
      end

      private
      attr_reader :response

      def extract_metadata
       Metadata.new(response)
      end
    end

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
        Array.new('')
      end

      def parsed_timing_info
        Timing.new(response)
      end
    end

    class Timing
      def initialize(raw_response_hash)
        @response = raw_response_hash
      end
    end

  end
end
