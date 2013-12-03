module Cb::Responses::Balls
  module Spot

    class Retrieve < Cb::Responses::RawApiResponse
      class << self
        def extract_models(raw_api_response)
          new(raw_api_response).extract_models
        end
      end

      def validate_raw_api_response
        required_response_field root_node, raw_api_hash
        required_response_field spot_collection, root_hash
      end

      def extract_models
        spot_models = spot_hashes.map { |spot_data| Cb::Models::Spot.new(spot_data) }
        Cb::Utils::Api.new.append_api_responses(spot_models, root_hash)
      end
      
      private
      
      def root_node
        @root_node ||= 'ResponseRetrieve'
      end
      
      def spot_collection
        @spot_collection ||= 'SpotData'
      end

      def spot_hashes
        raw_api_hash[root_node][spot_collection]
      end
    end

  end
end
