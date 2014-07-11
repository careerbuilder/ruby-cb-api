module Cb
  module Models
    class CollapsedJobs < ApiResponseModel
      attr_accessor :jobs_in_group, :jobs

      def initialize(args={})
        super(args)
      end

      protected

      def required_fields
        []
      end

      def set_model_properties
        args = api_response

        @jobs_in_group = args['NumberJobsInGroup']
        @jobs = get_jobs(args['GroupedSearchResults'])
      end

      def get_jobs(jobs_hash)
        jobs_hash.collect do |job|
          Job.new(job)
        end
      end
    end
  end
end