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

        @jobs_in_group = args['NumberJobsInGroup']
        @jobs = get_jobs(args['GroupedSearchResults'])
        @grouping_valueargs['GroupingValue']
      end

      def get_jobs(jobs_hash)
        jobs_hash.collect do |job|
          Job.new(job)
        end
      end
    end
  end
end