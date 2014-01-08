require 'json'

module Cb::ApiClients
  class Spot
    class << self

      def retrieve(criteria)
        response = retrieve_api_response criteria
        Cb::Responses::Spot::Retrieve.extract_models response
      end

      private

      def retrieve_api_response(criteria)
        params = api_client.class.criteria_to_hash criteria
        api_client.cb_get(Cb.configuration.uri_spot_retrieve, :query => params)
      end

      def api_client
        @api ||= Cb::Utils::Api.new
      end

    end
  end
end
