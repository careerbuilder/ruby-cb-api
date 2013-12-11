module Cb
  module Responses
    module AnonymousSavedSearch

      class Create < ApiResponse
        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
          required_response_field(external_id_node, response)
          required_response_field(model_node, response)
        end

        def extract_models
          # external ID comes back outside of the model node so we need to do some rearranging
          response[model_node][external_id_node] = response[external_id_node]
          Models::SavedSearch.new(response[model_node])
        end

        private

        def model_node
          'AnonymousSavedSearch'
        end

        def external_id_node
          'ExternalID'
        end
      end

    end
  end
end
