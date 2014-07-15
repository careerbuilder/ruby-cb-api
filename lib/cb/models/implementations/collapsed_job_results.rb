module Cb
  module Models
    class CollapsedJobResults
      attr_reader :args_hash, :last_item_index, :search_location, :grouped_jobs, :grouping_parameter, :total_count, :total_pages, :first_item_index, :last_item_index
      def initialize(args_hash)
        @args_hash = args_hash
        @last_item_index = args_hash['LastItemIndex']
        @search_location = args_hash['SearchMetaData']['SearchLocations']['SearchLocation'] rescue nil
        @grouping_parameter = args_hash['GroupedJobSearchResults']['GroupingParameter']
        @grouped_jobs = extract_collapsed_jobs(args_hash['GroupedJobSearchResults']['SearchResults']['JobSearchResultsGroup'])
        @total_pages = args_hash['TotalPages']
        @total_count = args_hash['TotalCount']
        @first_item_index = args_hash['FirstItemIndex']
        @last_item_index = args_hash['LastItemIndex']
      end

      private

      def extract_collapsed_jobs(collapsed_jobs)
        collapsed_jobs.collect do |collapsed_job|
          CollapsedJobs.new(collapsed_job)
        end
      end

    end
  end
end
