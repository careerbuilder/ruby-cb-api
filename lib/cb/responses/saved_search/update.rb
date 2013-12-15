module Cb
  module Responses
    module SavedSearch

      class Update < ApiResponse
        protected

        def validate_api_hash
          required_response_field(model_node, response)
        end

        def hash_containing_metadata
          response
        end

        def extract_models
          Models::SavedSearch.new(response[model_node])
        end

        private

        def model_node
          'SavedJobSearch'
        end
      end

    end
  end
end
