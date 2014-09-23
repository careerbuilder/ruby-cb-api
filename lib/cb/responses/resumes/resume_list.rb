module Cb
  module Responses
    class ResumeList < ApiResponse
      def validate_api_hash
        required_response_field(root_node, response)
      end

      def extract_models
        response[root_node].map do |resume| Models::ResumeListing.new(resume) end
      end

      def hash_containing_metadata
        response
      end

      def root_node
        'Resumes'
      end
    end
  end
end
