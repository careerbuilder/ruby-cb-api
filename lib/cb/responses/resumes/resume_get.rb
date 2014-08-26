module Cb
  module Responses
    module Resumes
      class ResumeGet < ApiResponse
        def validate_api_hash
          required_response_field('Results', response)
        end

        def extract_models
          response['results'].map { |resume| Models::Resume.new(resume) }
        end

        def hash_containing_metadata
          response
        end

      end
    end
  end
end
