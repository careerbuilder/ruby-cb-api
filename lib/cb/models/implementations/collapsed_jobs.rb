module Cb
  module Models
    class CollapsedJobs < ApiResponseModel
      attr_accessor :jobs_in_group, :job_description, :grouping_value

      def initialize(args = {})
        super(args)
      end

      def job_count
        @jobs_in_group
      end

      def job
        @job_description
      end

      protected

      def required_fields
        []
      end

      def set_model_properties
        args = api_response
        @jobs_in_group = args['NumberJobsInGroup']
        @job_description = get_jobs(args['GroupedSearchResults']['JobSearchResult'])
        @grouping_value = args['GroupingValue']
      end

      def get_jobs(jobs_hash)
        Job.new(jobs_hash)
      end
    end
  end
end