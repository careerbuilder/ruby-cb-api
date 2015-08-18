module Cb
  module Models
    class JobResultsV3
      attr_reader :api_response
      
      def initialize(response_hash = {})
        @api_response = response_hash
      end
    end
  end
end
