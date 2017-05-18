# Copyright 2017 CareerBuilder, LLC
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
  describe Cb::Clients::JobSearch do
    describe '#get' do
      subject { Cb::Clients::JobSearch.get(oauth_token: 'token', keywords: 'Kanye West', location: 'Chi-town') }

      let(:headers) do
        {
          'Accept' => 'application/json;version=3.0',
          'Accept-Encoding' => 'deflate, gzip',
          'Authorization' => 'Bearer token',
          'Content-Type' => 'application/json',
          'Developerkey' => Cb.configuration.dev_key,
          'Hostsite' => 'US'
        }
      end

      let(:uri) { "https://api.careerbuilder.com/consumer/jobs/search/?developerkey=#{ Cb.configuration.dev_key }&keywords=Kanye%20West&location=Chi-town&outputjson=true" }
      let(:stub) do
        stub_request(:get, uri).
          with(headers: headers).
          to_return(status: 200, body: {}.to_json)
      end


      before do
        stub
        subject
      end

      it { expect(stub).to have_been_requested }
    end
  end
end
