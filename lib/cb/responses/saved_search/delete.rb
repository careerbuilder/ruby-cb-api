module Cb
  module Responses
    module SavedSearch

      class Delete < ApiResponse
        protected

        def validate_api_hash
          required_response_field(root_node, response)
        end

        def hash_containing_metadata
          response
        end

        def extract_models
          Models::SavedSearch.new(response[root_node])
        end

        private

        def root_node
          'Request'
        end
      end

    end
  end
end
