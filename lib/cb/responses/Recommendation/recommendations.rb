module Cb
  module Responses
    class Recommendations < ApiResponse

      def validate_api_hash
        check_nonstandard_error_node(response)
        required_response_field(root_node, response)
        required_response_field('results', response[root_node])
      end

      def hash_containing_metadata
        nil
      end

      def has_service_unavailable_indicator(error_message)
        return error_message.include?('This service is down for maintenance') || error_message.include?('Please try again later')
      end

      def extract_models
        response[root_node]['results'].map { |cur_job| Models::RecommendedJob.new(cur_job) }
      end

      def root_node
        'data'
      end

      private

      def check_nonstandard_error_node(api_response)
        fail ApiResponseError.new(api_response['Message']) if api_response.include?('Message')
      end
    end
  end
end
