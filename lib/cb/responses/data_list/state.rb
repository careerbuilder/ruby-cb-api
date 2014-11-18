module Cb
  module Responses
    class State < ApiResponse
      def Validate_api_hash
        required_response_field(root_node, response)
      end

      def extract_models
        response[root_node].map { |state| Models::State.new(state) }
      end

      def hash_containing_metadata
        response
      end

      def root_node
        "Results"
      end

    end
  end
end
