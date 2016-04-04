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
  module Clients
    describe ResumeInsights do
      include_context :stub_api_following_standards

      before do
        stub
        subject
      end

      describe '#keywords' do
        let(:uri) { "https://api.careerbuilder.com/consumer/insights/keywords/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

        subject { Cb::Clients::ResumeInsights.keywords(id: 'id', oauth_token: 'token') }

        context 'successfully returns a keyword list by id' do
          let(:response) { JSON.parse File.read('spec/support/response_stubs/resume_insights/keywords.json') }
          let(:stub) do
            stub_request(:get, uri)
              .with(headers: headers)
              .to_return(status: 200, body: response.to_json)
          end

          it { expect(stub).to have_been_requested }
          it { is_expected.to eq response }
        end

        context 'when keywords are not found for a given id' do
          let(:data){ [{ 'type' => '404', 'message' => 'Document not found', 'code' => '404' }] }
          let(:response) { { 'errors' => [ data ].flatten }.merge({ 'page' => -1, 'page_size' => -1, 'total' => 0 }) }
          let(:stub) do
            stub_request(:get, uri).
              with(:headers => headers).
              to_return(:status => 404, :body => response.to_json)
          end

          it { expect(stub).to have_been_requested }
          it { is_expected.to eq response }
        end
      end
    end
  end
end
