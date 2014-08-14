module Cb
  module Models
    class Recommendations < ApiResponseModel
      attr_reader :results, :search_metadata

      def required_fields
        [results, search_metadata]
      end

      def set_model_properties
        args = api_response
        @results = []
        if args.has_key?('data')
          if args['data'].has_key?('results')
            args['data']['results'].each do |cur_job|
              @results << Models::RecommendedJob.new(cur_job)
            end
          end
        end
        @search_metadata = args['search_metadata']
      end
    end
  end
end