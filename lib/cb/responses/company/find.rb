require 'cb/responses/api_response'

module Cb
  module Responses
    module Company
      class Find < ApiResponse

        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
          required_response_field(results_node, response)
          required_response_field(company_profile_node, response[results_node])
        end

        def extract_models
          Cb::Models::Company.new(company)
        end

        private

        def results_node
          "Results"
        end

        def company_profile_node
          "CompanyProfileDetail"
        end

        def company
          response[results_node][company_profile_node]
        end
      end
    end
  end
end
