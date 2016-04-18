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

module Cb
  describe Cb::Clients::ExpiredJob do
    include_context :stub_api_following_standards
 
    let(:uri) { "https://api.careerbuilder.com/v1/job/expired?JobDID=blah&developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }
    let(:stub) do
      stub_request(:get, uri).
        with(headers: headers).
        to_return(status: 200, body: api_response.to_json)
      end

    subject { Cb::Clients::ExpiredJob.get(job_did: 'blah', oauth_token: 'token') }

    before do
      stub
      subject
    end

    describe '#get' do
  
      context 'Job DID is expired' do
        let(:api_response) { JSON.parse File.read('spec/support/response_stubs/expired_job.json') }

        it { expect(stub).to have_been_requested }
        it { is_expected.to eq api_response }
      end

      context 'Job DID is not expired' do
        let(:api_response) { JSON.parse File.read('spec/support/response_stubs/nonexpired_job.json') }

        it { expect(stub).to have_been_requested }
        it { is_expected.to eq api_response }
      end
 
      context 'Job DID is not valid' do
        let(:api_response) { JSON.parse File.read('spec/support/response_stubs/invalid_job.json') }

        it { expect(stub).to have_been_requested }
        it { is_expected.to eq api_response }
      end
    end
  end
end
