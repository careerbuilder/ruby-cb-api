module Cb
  module Responses
    module Job
      class SearchV3 < ApiResponse

        protected

        def validate_api_hash
          required_response_field(root_node, response)
        end

        def hash_containing_metadata
          'search_metadata'
        end

        def extract_models
          Models::JobResultsV3.new(response)
        end

        private

        def root_node
          'data'
        end
      end
    end
  end
end
