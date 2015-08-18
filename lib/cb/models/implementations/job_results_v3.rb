module Cb
  module Models
    class JobResultsV3
      attr_reader :api_response
      attr_reader :response_metadata
      
      def initialize(response_hash = {})
        @api_response = response_hash['data']
        @response_metadata = response_hash['search_metadata']
      end
    end
  end
end
