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
  describe Cb::Clients::Resumes do
    let(:headers) do
      {
        'Accept-Encoding' => 'deflate, gzip',
        'Authorization' => 'Bearer token',
        'Content-Type' => 'application/json;version=1.0',
        'Developerkey' => Cb.configuration.dev_key,
        'HostSite' =>'US'
      }
    end

    describe '#get' do
      let(:uri) { "https://api.careerbuilder.com/consumer/resumes?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }
      let(:api_response) { JSON.parse File.read('spec/support/response_stubs/resumes.json') }
      let(:stub) do
        stub_request(:get, uri).
          with(headers: headers).
          to_return(status: 200, body: api_response.to_json)
      end

      subject { Cb::Clients::Resumes.get(oauth_token: 'token') }

      before do
        stub
        subject
      end

      it { expect(stub).to have_been_requested }
      it { is_expected.to eq api_response }

      context 'When given a site' do
        let(:expected_additional_param) { 'site=US' }
        let(:uri) { "https://api.careerbuilder.com/consumer/resumes?developerkey=#{ Cb.configuration.dev_key }&outputjson=true&#{ expected_additional_param }" }

        subject { Cb::Clients::Resumes.get(site: 'US', oauth_token: 'token') }

        it { expect(stub).to have_been_requested }
        it { is_expected.to eq api_response }
      end
    end
  end
end
