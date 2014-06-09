require 'cb/responses/api_response'

module Cb
  module Responses
    module EmailSubscription
      class Response < ApiResponse

        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
          required_response_field(response_node, response)
        end

        def extract_models
          Cb::Models::EmailSubscription.new(model_hash)
        end

        private

        def response_node
          "SubscriptionValues"
        end

        def model_hash
          response[response_node]
        end
      end
    end
  end
end
