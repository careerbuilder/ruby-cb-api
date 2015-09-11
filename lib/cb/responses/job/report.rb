module Cb
  module Responses
    module Job
      class Report < ApiResponse

        def validate_api_hash
          required_response_field(root_node, success)
        end

        def extract_models
          response[root_node].map do |success|
            Cb::Models::ReportJob.new(success: success)
          end
        end

        def root_node
          'ResponseReportJob'
        end
        
      end
    end
  end
end
