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
require 'spec_helper'
require 'webmock'
require 'dotenv'

Dotenv.load
WebMock.allow_net_connect!

Cb.configuration.dev_key = ENV['DEVELOPER_KEY']
Cb.configuration.debug_api = false

module Cb::Clients
  describe 'PUT requests' do
    describe Application do
      describe '::update' do
        before(:all) do
          job_did = 'JHQ4LP5YY6S4HLFTVM0'
          resume = Cb::Criteria::Application::Resume.new
                   .external_resume_id('XRHN1QJ6V0DZPZHBPZNM')
                   .resume_file_name('my resume')
                   .resume_data(1_010_101_010_101)
                   .resume_extension('pdf')
                   .resume_title('Nurse')
          cover_letter = Cb::Criteria::Application::CoverLetter.new
          resume_responses = []
          criteria = Cb::Criteria::Application::Update.new
                     .application_did('JAHH0636ZLWMF8DRW30T')
                     .job_did(job_did)
                     .is_submitted(false)
                     .external_user_id('XRHL5WB644K882Z72Y7B')
                     .vid('hamburger_avalanche')
                     .bid('bid_123')
                     .sid('sid_123')
                     .site_id('site_123')
                     .ipath_id('ipath_123')
                     .tn_did('tn_123')
                     .resume(resume)
                     .cover_letter(cover_letter)
                     .responses(resume_responses)
          @response = Cb::Clients::Application.update(criteria)
        end

        it 'returns a valid response' do
          @response.should be_a Cb::Responses::Application
        end

        it 'responds to errors' do
          @response.errors.should be_a Cb::Responses::Errors
          @response.errors.parsed.should be_empty
        end

        it 'responds to timings' do
          @response.timing.should be_a Cb::Responses::Timing
          # @response.timing.elapsed.should_not be_nil
        end

        it 'returns a real job model w/ attributes' do
          @response.model[0].should be_a Cb::Models::Application
          @response.model[0].application_did.should include 'JA'
        end
      end
    end
  end
end
