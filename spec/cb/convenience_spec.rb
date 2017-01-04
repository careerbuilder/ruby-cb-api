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
require 'spec_helper'

module Cb
  describe Convenience::ClassMethods do
    def expect_method_to_return_class(method, klass)
      returned_convenience_class = Cb.send(method)
      expect(returned_convenience_class).to be klass
    end

    def expect_method_to_return_type_of_class(method, klass, args = nil)
      returned_convenience_class = args ? Cb.send(method, args) : Cb.send(method)
      expect(returned_convenience_class).to be_a klass
    end

    describe '#api_client' do
      it 'returns the main CB utility client for POSTing and GETting' do
        expect_method_to_return_class(:api_client, Cb::Utils::Api)
      end
    end

    describe '#job' do
      it 'returns the job api client class' do
        expect_method_to_return_class(:job, Cb::Clients::Job)
      end
    end

    describe '#job_insights' do
      it 'returns the job insight api client class' do
        expect_method_to_return_class(:job_insights, Cb::Clients::JobInsights)
      end
    end

    describe '#browser_id' do
      it 'returns the browser id api client class' do
        expect_method_to_return_class(:browser_id, Cb::Clients::BrowserID)
      end
    end

    describe '#company' do
      it 'returns the company api client class' do
        expect_method_to_return_class(:company, Cb::Clients::Company)
      end
    end

    describe '#cover_letters' do
      it 'returns the cover letter api client class' do
        expect_method_to_return_class(:cover_letters, Cb::Clients::CoverLetters)
      end
    end

    describe '#data_list' do
      it 'returns the data list api client class' do
        expect_method_to_return_class(:data_list, Cb::Clients::DataList)
      end
    end

    describe '#expired_job' do
      it 'returns the expired job api client class' do
        expect_method_to_return_class(:expired_job, Cb::Clients::ExpiredJob)
      end
    end

    describe '#recommendation' do
      it 'returns the recommendation api client class' do
        expect_method_to_return_class(:recommendation, Cb::Clients::Recommendation)
      end
    end

    describe '#resume_insights' do
      it 'returns the resume insight api client class' do
        expect_method_to_return_class(:resume_insights, Cb::Clients::ResumeInsights)
      end
    end
    
    describe '#saved_jobs' do
      it 'returns the saved jobs api client class' do
        expect_method_to_return_class(:saved_jobs, Cb::Clients::SavedJobs)
      end
    end

    describe '#resumes' do
      it { expect_method_to_return_class(:resumes, Cb::Clients::Resumes) }
    end

    describe '#application' do
      it 'returns the application api client class' do
        expect_method_to_return_class(:application, Cb::Clients::Application)
      end
    end

    describe '#application_external' do
      it 'returns the application_external api client class' do
        expect_method_to_return_class(:application_external, Cb::Clients::ApplicationExternal)
      end
    end

    describe '#country' do
      it 'returns the country utility class' do
        expect_method_to_return_class(:country, Cb::Utils::Country)
      end
    end

    describe '#user' do
      it 'returns the user api client class' do
        expect_method_to_return_class(:user, Cb::Clients::User)
      end
    end

    describe '#application' do
      it 'returns the job branding api client class' do
        expect_method_to_return_class(:job_branding, Cb::Clients::JobBranding)
      end
    end

    describe '#saved_search' do
      it 'returns the saved search api client class' do
        expect_method_to_return_class(:saved_search, Cb::Clients::SavedSearch)
      end
    end

    describe '#talent_network' do
      it 'returns the TN api client class' do
        expect_method_to_return_class(:talent_network, Cb::Clients::TalentNetwork)
      end
    end

    describe '#anon_saved_search' do
      it 'returns the anonymous saved search api client class' do
        expect_method_to_return_class(:anon_saved_search, Cb::Clients::AnonSavedSearch)
      end
    end

    describe '#user_rpofile' do
      it 'returns the TN api client class' do
        expect_method_to_return_class(:user_profile, Cb::Clients::UserProfile)
      end
    end
  end
end
