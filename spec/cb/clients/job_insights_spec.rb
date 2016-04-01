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
    include_context :stub_api_following_standards

    let(:data) { [JSON.parse( File.read('spec/support/response_stubs/job_insights.json'))] }
    let(:uri) { "https://api.careerbuilder.com/consumer/job-insights/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

    describe '#get' do
      context 'asking for a specific job insights report' do
        it 'performs a get and returns the job report asked for' do
          stub = stub_request(:get, uri).
              with(:headers => headers).
              to_return(:status => 200, :body => response.to_json)

          response = Cb::Clients::JobInsights.get(id: 'id', oauth_token: 'token')
          expect_api_to_succeed_and_return_model(response, stub)
        end
      end

      context 'when the job insights report is not found' do
        let(:data){ [{ 'type' => '404', 'message' => 'Could not find the specified job report', 'code' => '404' }] }

        it 'returns the error hash' do
          stub = stub_request(:get, uri).
              with(:headers => headers).
              to_return(:status => 404, :body => error_response.to_json)
          begin
            Cb::Clients::JobInsights.get(id: 'id', oauth_token: 'token')
            expect(false).to eq(true)
          rescue Cb::DocumentNotFoundError => error
            expect_api_to_error(error, stub)
          end
        end
      end
    end
  end
end
