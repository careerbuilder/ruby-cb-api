module Cb
  module Responses
    module AnonymousSavedSearch

      class Delete < ApiResponse
        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
          required_response_field(status_node, response)
        end

        def extract_models
          Models::SavedSearch::Delete.new(response[status_node])
        end

        private

        def status_node
          'Status'
        end
      end

    end
  end
end
