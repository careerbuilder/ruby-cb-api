module Cb
  module Responses
    module Recommendation
      class Recommendations < ApiResponse

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field('results', response[root_node])
        end

        def hash_containing_metadata
          response[root_node]
        end


        def extract_models
          response[root_node]['results'].map { |cur_job| Models::RecommendedJob.new(cur_job) }
        end

        def root_node
          'data'
        end
      end
    end
  end
end