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
          required_response_field(work_statuses_node, response)
        end

        def extract_models
          [ model_array ].flatten.map { |work_status| Cb::Models::WorkStatus.new work_status }
        end

        private

        def work_statuses_node
          "WorkStatuses"
        end

        def model_array
          response[work_statuses_node]
        end

      end
    end
  end
end
