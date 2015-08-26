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
