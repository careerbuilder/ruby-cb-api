module Cb
  module Responses
    class ResumeDocument < ApiResponse
      attr_accessor :resume_id, :desired_job_title, :privacy_setting, :resume_file_data, :resume_file_name, :host_site

      def validate_api_hash
        required_response_field(root_node, response)
      end

      def extract_models
        response[root_node].map { |resume| Models::ResumeDocument.new(resume) }
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
