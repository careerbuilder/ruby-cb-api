module Cb
  module Responses
    module SavedSearch

      class List < ApiResponse
        protected

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(outer_collection_node, response[root_node])
          required_response_field(inner_collection_node, response[root_node][outer_collection_node])
        end

        def hash_containing_metadata
          response
        end

        def extract_models
          model_hashes.map { |model_data| Models::SavedSearch.new(model_data) }
        end

        private

        def root_node
          'SavedJobSearches'
        end

        def outer_collection_node
          'SavedSearches'
        end

        def inner_collection_node
          'SavedSearch'
        end

        def model_hashes
          Utils::ResponseArrayExtractor.extract(response[root_node], outer_collection_node, inner_collection_node)
        end
      end

    end
  end
end
