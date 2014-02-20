require 'cb/responses/api_response'

module Cb
  module Responses
    class Application < ApiResponse

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
