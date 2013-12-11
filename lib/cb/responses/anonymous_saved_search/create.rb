module Cb
  module Responses
    module AnonymousSavedSearch

      class Create < ApiResponse
        protected

        def hash_containing_metadata
          response[root_node]
        end

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field('ExternalID', response)
        end

        def extract_models
          response
        end

        private

        def root_node
          'AnonymousSavedSearch'
        end
      end

    end
  end
end
