module Cb
  module Responses
    module SavedSearch
      class List < ApiResponse
       
        protected

        def validate_api_hash
          required_response_field(collection_node, response)
        end

        def hash_containing_metadata
          response
        end

        def extract_models
          model_hashes.map { |model_data| Models::SavedSearch.new(model_data) }
        end

        private

        def collection_node
          'Results'
        end

        def model_hashes
          response[collection_node]
        end
      end

    end
  end
end
