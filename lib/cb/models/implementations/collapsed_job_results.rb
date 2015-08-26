# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
module Cb
  module Models
    class CollapsedJobResults
      attr_reader :args_hash, :last_item_index, :search_location, :grouped_jobs, :grouping_parameter, :total_count, :total_pages, :first_item_index, :last_item_index
      def initialize(args_hash)
        @args_hash = args_hash
        @last_item_index = args_hash['LastItemIndex']
        @search_location = args_hash['SearchMetaData']['SearchLocations']['SearchLocation'] rescue nil
        @grouping_parameter = args_hash['GroupedJobSearchResults']['GroupingParameter']
        @grouped_jobs = extract_collapsed_jobs(Cb::Utils::ResponseArrayExtractor.extract(args_hash['GroupedJobSearchResults'],
                                                                                         'SearchResults', 'JobSearchResultsGroup'))
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
