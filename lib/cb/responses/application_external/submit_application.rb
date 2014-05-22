require 'cb/responses/api_response'

module Cb
  module Responses
    class SubmitApplication < ApiResponse

      protected

      def hash_containing_metadata
        response
      end

      def validate_api_hash
        required_response_field('Results', response)
      end

      def extract_models
        response['Results'].map { |app_form_data| Cb::Models::Application::Form.new(app_form_data) }
      end

    end
  end
end
