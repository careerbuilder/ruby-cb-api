module Cb
  module Responses
    module Recommendation
      class Recommendations < ApiResponse

        def required_fields
          [results, search_metadata]
        end

        def validate_api_hash
          required_response_field(root_node, response)
        end

        def hash_containing_metadata
          response[root_node]
        end


        def extract_models
          args = response
          @results = []
          if args.has_key?('data')
            if args['data'].has_key?('results')
              args['data']['results'].each do |cur_job|
                @results << Models::RecommendedJob.new(cur_job)
              end
            end
          end
          @results
        end

        def root_node
          'data'
        end
      end
    end
  end
end