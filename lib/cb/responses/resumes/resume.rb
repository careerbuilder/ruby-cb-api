module Cb
  module Responses
    class Resume < ApiResponse
      def validate_api_hash
        required_response_field(root_node, response)
      end

      def extract_models
        response[root_node].map { |resume| Models::Resume.new(resume) }
      end

      def hash_containing_metadata
        response
      end

      def root_node
        'Results'
      end

    end
  end
end
