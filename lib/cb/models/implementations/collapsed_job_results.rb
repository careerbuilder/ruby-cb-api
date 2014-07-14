module CB
  module Models
    class CollapsedJobResults
      attr_reader :args_hash, :total_count, :last_item_index, :search_location, :grouped_jobs, :grouping_parameter
      def initialize(args_hash)
        @args_hash = args_hash
        @total_count = args_hash['TotalCount']
        @last_item_index = args_hash['LastItemIndex']
        @search_location = args_hash['SearchMetaData']['SearchLocations']['SearchLocation'] rescue nil
        @grouping_parameter = args_hash['GroupedJobSearchResults']['GroupingParameter']
        @grouped_jobs = extract_collapsed_jobs(args_hash['GroupedJobSearchResults']['SearchResults'])
      end

      private

      def extract_collapsed_jobs(collapsed_jobs)
        collapsed_jobs.collect do |collapsed_job|
          CollapsedJobs.new(job_hash)
        end
      end

    end
  end
end
