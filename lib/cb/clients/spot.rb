require 'json'

module Cb
  module Clients
    class Spot
      class << self

        def retrieve(criteria)
          response = retrieve_api_response criteria
          Cb::Responses::Spot::Retrieve.new(response)
        end

        private

        def api_client
          @api ||= Cb::Utils::Api.instance
        end

      end
    end
  end
end
