module Cb
  module Responses
    module SavedSearch

      class Retrieve < ApiResponse
        protected

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(model_node, response[root_node])
        end

        def hash_containing_metadata
          response[root_node]
        end

        def extract_models
          Models::SavedSearch.new(response[root_node][model_node])
        end

        private

        def root_node
          'SavedJobSearch'
        end

        def model_node
          'SavedSearch'
        end
      end

    end
  end
end
