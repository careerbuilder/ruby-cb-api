module Cb
  module Responses
    module AnonymousSavedSearch

      class Delete < ApiResponse
        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
          required_response_field('Status', response)
        end

        def extract_models
          Models::SavedSearch::Delete.new(response)
        end
      end

    end
  end
end
