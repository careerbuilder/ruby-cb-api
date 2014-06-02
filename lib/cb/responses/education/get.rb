require 'cb/responses/api_response'

module Cb
  module Responses
    module Education
      class Get < ApiResponse

        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
          required_response_field(response_node, response)
          required_response_field(education_codes_node, response[response_node])
          required_response_field(education_array_node, response[response_node][education_codes_node])
        end

        def extract_models
          model_array.map { |category| Cb::Models::Education.new(category) }
        end

        private

        def response_node
          "ResponseEducationCodes"
        end

        def education_codes_node
          "EducationCodes"
        end

        def education_array_node
          "Education"
        end

        def model_array
          response[response_node][education_codes_node][education_array_node]
        end
      end
    end
  end
end
