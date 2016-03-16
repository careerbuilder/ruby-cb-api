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
  describe Cb::Clients::JobInsights do
    let(:response) do
      {
          'data' => [ data ].flatten,
          'page' => 1,
          'page_size' => 1,
          'total' => 1
      }
    end
    let(:error_response) do
      {
          'errors' => [ data ].flatten,
          'page' => -1,
          'page_size' => 0,
          'total' => 0
      }
    end
    let(:headers) do
      {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'deflate, gzip',
          'Authorization'=>'Bearer token',
          'Content-Type' => 'application/json',
          'Developerkey'=> Cb.configuration.dev_key
      }
    end

    context '#get' do
      context 'asking for a specific job insights report' do
        let(:response) { JSON.parse File.read('spec/support/response_stubs/job_insights.json') }
        let(:uri) { "https://api.careerbuilder.com/consumer/job-insights/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

        it 'performs a get and returns the job report asked for' do
          stub = stub_request(:get, uri).
              with(:headers => headers).
              to_return(:status => 200, :body => response.to_json)

          response = Cb::Clients::JobInsights.get(id: 'id', oauth_token: 'token')
          expect(stub).to have_been_requested
          expect(response.class).to eq(Hash)
          expect(response['data'].class).to eq(Array)
          expect(response['data'].length).to eq(1)
        end
      end

      context 'when the job insights report is not found' do
        let(:data){ { 'type' => '404', 'message' => 'Could not find the cover letter specified', 'code' => '404' } }
        let(:uri) { "https://api.careerbuilder.com/consumer/job-insights/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

        it 'returns the error hash' do
          stub = stub_request(:get, uri).
              with(:headers => headers).
              to_return(:status => 404, :body => error_response.to_json)

          response = Cb::Clients::JobInsights.get(id: 'id', oauth_token: 'token')
          expect(stub).to have_been_requested
          expect(response.class).to eq(Hash)
          expect(response['errors'].class).to eq(Array)
          expect(response['errors'].length).to eq(1)
          expect(response['errors'][0]).to eq(data)
        end
      end
    end
  end
end
