module Cb
  module Responses
    module Job
  	  class Singular < ApiResponse

        protected

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(model_node, response[root_node])
        end

        def hash_containing_metadata
          response[root_node]
        end

        def extract_models
          p " - - Should return Cb::Models::Job !! - - "
          Models::Job.new(model_hash)
        end

        private

        def root_node
          'ResponseJob'
        end

        def model_node
          'Job'
        end

        def model_hash
          response[root_node][model_node]
        end
      end
  	end
  end
end