module Cb::Responses::Spot
  class Retrieve < Cb::Responses::RawApiResponse

    ROOT_NODE = 'ResponseRetrieve'
    SPOT_COLLECTION = 'SpotData'

    class << self
      def extract_models(raw_api_response)
        new(raw_api_response).extract_models
      end
    end

    def initialize(raw_api_response={})
      super(raw_api_response)
    end

    def validate_raw_api_response
      required_response_field ROOT_NODE, raw_api_hash
      required_response_field SPOT_COLLECTION, raw_api_hash[ROOT_NODE]
    end

    def extract_models
      spot_models = raw_api_hash[ROOT_NODE][SPOT_COLLECTION].map { |spot_data| Cb::Models::Spot.new(spot_data) }
      Cb::Utils::Api.new.append_api_responses(spot_models, raw_api_hash[ROOT_NODE])
    end

  end
end
