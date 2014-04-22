module Cb
  module Responses
    module SavedSearch
      class Update < ApiResponse

        protected

        def validate_api_hash
          required_response_field(collection_node, response)
        end

        def hash_containing_metadata
          response
        end

        def extract_models
          Models::SavedSearch.new(model_hash)
        end

        private

        def collection_node
          'Results'
        end

        def model_hash
          response[collection_node][0]
        end
      end

    end
  end
end