module Cb
  module Models
    class CollapsedJobs < ApiResponseModel
      attr_accessor :jobs_in_group, :jobs, :grouping_value

      def initialize(args={})
        super(args)
      end

      def job_count
        @jobs_in_group
      end

      def all_jobs
        @jobs
      end

      protected

      def required_fields
        []
      end

      def set_model_properties
        args = api_response

        @jobs_in_group = args[0]['NumberJobsInGroup']
        @jobs = get_jobs(args[0]['GroupedSearchResults'])
        @grouping_valueargs[0]['GroupingValue']
      end

      def get_jobs(jobs_hash)
        Job.new(jobs_hash)
      end
    end
  end
end