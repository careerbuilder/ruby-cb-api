module Cb
  module Responses
    module Job
      class Search < ApiResponse

        protected

        def validate_api_hash
          required_response_field(root_node, response)
        end

        def hash_containing_metadata
          response[root_node]
        end

        def extract_models
          if is_collapsed
            Models::CollapsedJobResults.new(response[root_node])
          else
            Models::JobResults.new(response[root_node], job_hashes)
          end
        end

        private

        def root_node
          'ResponseJobSearch'
        end

        def job_hashes
          hashes = response[root_node]['Results']['JobSearchResult'] rescue []

          if hashes.is_a?(Array)
            hashes
          else
            [hashes]
          end
        end

        def is_collapsed
          response[root_node].key?('GroupedJobSearchResults')
        end
      end
    end
  end
end
