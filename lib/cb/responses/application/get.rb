module Cb
  module Responses
    module Application
      class Get < Responses::ApiResponse

        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
          required_response_field('Results', response)
        end

        def extract_models
          response['Results'].map { |application_data| Cb::Models::Application.new(application_data) }
        end

      end
    end
  end
end
