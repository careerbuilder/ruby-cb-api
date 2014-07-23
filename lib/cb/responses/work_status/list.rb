require 'cb/responses/api_response'

module Cb
  module Responses
    module WorkStatus
      class List < ApiResponse

        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
          required_response_field(response_node, response)
          required_response_field(work_status_codes_node, response[response_node])
          required_response_field(work_status_array_node, response[response_node][work_status_codes_node])
        end

        def extract_models
          [ model_array ].flatten.map { |work_status| Cb::Models::WorkStatus.new work_status }
        end

        private

        def response_node
          "WorkStatusRetrieveResponse"
        end

        def work_status_codes_node
          "WorkStatuses"
        end

        def work_status_array_node
          "WorkStatus"
        end

        def model_array
          response[response_node][work_status_codes_node][work_status_array_node]
        end

      end
    end
  end
end
