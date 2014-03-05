module Cb
  module Responses
    module Jobs
      class Search < ApiResponse

        protected

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(results_node, response[root_node])
          required_response_field(job_result_node, response[root_node][results_node])
        end

        def hash_containing_metadata
          response[root_node]
        end

        def extract_models
          Models::JobResults.new(response[root_node], job_hashes)
        end

        private

        def root_node
          'ResponseJobSearch'
        end

        def results_node
          'Results'
        end

        def job_result_node
          'JobSearchResult'
        end

        def job_hashes
          hashes = response[root_node][results_node][job_result_node]

          if hashes.is_a?(Array)
            hashes
          else
            [hashes]
          end
        end

      end
    end
  end
end