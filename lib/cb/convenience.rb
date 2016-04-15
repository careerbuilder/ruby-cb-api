# Copyright 2016 CareerBuilder, LLC
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
  module Convenience
    module ClassMethods
      def anon_saved_search
        Cb::Clients::AnonSavedSearch
      end

      def api_client
        Cb::Utils::Api
      end

      def application
        Cb::Clients::Application
      end

      def application_external
        Cb::Clients::ApplicationExternal
      end

      def browser_id
        Cb::Clients::BrowserID
      end

      def country
        Cb::Utils::Country
      end

      def company
        Cb::Clients::Company
      end

      def cover_letters
        Cb::Clients::CoverLetters
      end

      def data_list
        Cb::Clients::DataList
      end

      def email_subscription
        Cb::Clients::EmailSubscription
      end

      def job
        Cb::Clients::Job
      end

      def job_branding
        Cb::Clients::JobBranding
      end

      def job_details_criteria
        Cb::Criteria::Job::Details.new
      end

      def job_insights
        Cb::Clients::JobInsights
      end

      def recommendation
        Cb::Clients::Recommendation
      end

      def resumes
        Cb::Clients::Resumes
      end

      def resume_insights
        Cb::Clients::ResumeInsights
      end

      def saved_jobs
        Cb::Clients::SavedJobs
      end

      def saved_search
        Cb::Clients::SavedSearch
      end

      def talent_network
        Cb::Clients::TalentNetwork
      end

      def user
        Cb::Clients::User
      end
    end
  end
end
