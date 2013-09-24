require 'json'

module Cb
  class SpotApi
    
    ROOT_NODE = 'ResponseRetrieve'
    SPOT_COLLECTION_NODE = 'SpotData'

    class << self
      def retrieve(criteria)
        response = retrieve_api_response criteria
        validate_api_response response
        extract_spot_models response
      end

      private

      def retrieve_api_response(criteria)
        params = api_client.class.criteria_to_hash criteria
        api_client.cb_get(Cb.configuration.uri_spot_retrieve, :query => params)
      end

      def validate_api_response(response)
        errors = Array.new
        errors.push ROOT_NODE unless response.has_key? ROOT_NODE
        errors.push SPOT_COLLECTION_NODE unless response[ROOT_NODE].has_key? SPOT_COLLECTION_NODE
        raise ExpectedResponseFieldMissing.new(errors.join(' ')) unless errors.empty?
      end

      def extract_spot_models(response)
        spot_models = response[ROOT_NODE][SPOT_COLLECTION_NODE].map { |spot_data| Cb::Spot.new spot_data }
        api_client.append_api_responses(spot_models, response[ROOT_NODE])
        spot_models
      end

      def api_client
        @api ||= Cb::Utils::Api.new
      end
    end

  end
end
