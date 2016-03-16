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
  describe 'GET requests' do
    describe Job do
      describe '#find_by_did' do
        context 'with a real job_did' do
          before(:all) do
            job_did = 'JHQ4LP5YY6S4HLFTVM0'
            @response = Cb::Clients::Job.find_by_did(job_did)
          end

          it 'returns a valid response' do
            @response.should be_a Cb::Responses::Job::Singular
          end

          it 'responds to errors' do
            @response.errors.should be_a Cb::Responses::Errors
            @response.errors.parsed.should be_empty
          end

          it 'responds to timings' do
            @response.timing.should be_a Cb::Responses::Timing
            @response.timing.elapsed.should_not be_nil
          end

          it 'returns a real job model w/ attributes' do
            @response.model.should be_a Cb::Models::Job
            @response.model.title.should == 'J1 Online Apply Mobile'
          end
        end
      end
    end
  end
end
