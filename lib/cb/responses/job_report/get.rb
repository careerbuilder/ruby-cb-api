module Cb
  module Responses
    module JobReport
      class Get < ApiResponse
        def validate_api_hash
          required_response_field(root_node, response)
        end

        def extract_models
          Models::JobReport.new(response[root_node][0])
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
end