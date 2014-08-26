module Cb
  module Responses
    module Resumes
      class ResumeGet < ApiResponse
        def validate_api_hash
          required_response_field('results', response)
        end

        def extract_models
          response['results'].map { |resume| Models::Resume.new(resume) }
        end

      end
    end
  end
end
