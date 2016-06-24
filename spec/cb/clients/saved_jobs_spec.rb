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
  describe Cb::Clients::SavedJobs do
    include_context :stub_api_following_standards

    let(:uri) { "https://api.careerbuilder.com/consumer/saved-jobs?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }
    let(:post_data) { { 'job_id' => 'J1234567891234567890', 'notes' => 'these are my notes' } }
    let(:saved_job) do
      {
          'id' => 'id', 'job_id' => 'J1234567891234567890', 'notes' => 'these are my notes',
          'site' => 'US', 'status' => 'Saved',
          'created_data' => '2016-03-02T14:29:30.617998-05:00', 'modified_date' => '2016-03-02T14:29:30.617998-05:00',
          'job_expired' => 'false', 'job_expired_date' => '2017-03-28T03:29:27.367', 'application_date' => '1970-01-01T00:00:00'

      }
    end
    let(:data) { [saved_job] }

    context '#create' do
      context 'when posting succeeds' do
        it 'performs a put with a saved-job in json format' do
          stub = stub_request(:put, uri)
          .with(body: post_data.to_json, headers: headers)
          .to_return(status: 200, body: response.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})
          response = Cb::Clients::SavedJobs.create(job_id: 'J1234567891234567890', notes: 'these are my notes', oauth_token: 'token')
          expect_api_to_succeed_and_return_model(response, stub)
        end
      end

      context 'when there is an error' do
        let(:data) { [{ 'type' => '500', 'message' => 'Some kind of error happened', 'code' => '500' }] }
        it 'returns the error hash' do
          stub = stub_request(:put, uri)
          .with(body: post_data.to_json, headers: headers)
          .to_return(status: 500, body: error_response.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})
          begin
            Cb::Clients::SavedJobs.create(job_id: 'J1234567891234567890', notes: 'these are my notes', oauth_token: 'token')
            expect(false).to eq(true)
          rescue Cb::ServerError => error
            expect_api_to_error(error, stub)
          end
        end
      end
    end

    context '#get' do
      context 'asking for all saved jobs' do
        let(:uri) { "https://api.careerbuilder.com/consumer/saved-jobs?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }
        let(:data) { [saved_job, saved_job, saved_job] }
        it 'performs a get and returns the results hash' do
          stub = stub_request(:get, uri)
          .with(headers: headers)
          .to_return(status: 200, body: response.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})

          response = Cb::Clients::SavedJobs.get(oauth_token: 'token')
          expect_api_to_succeed_and_return_model(response, stub)
        end
      end

      context 'asking for a specific saved job' do
        let(:uri) { "https://api.careerbuilder.com/consumer/saved-jobs/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

        it 'performs a get and returns the coverletter asked for' do
          stub = stub_request(:get, uri)
          .with(headers: headers)
          .to_return(status: 200, body: response.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})

          response = Cb::Clients::SavedJobs.get(id: 'id', oauth_token: 'token')
          expect_api_to_succeed_and_return_model(response, stub)
        end
      end

      context 'when the saved job is not found' do
        let(:uri) { "https://api.careerbuilder.com/consumer/saved-jobs/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

        it 'returns the error hash' do
          stub = stub_request(:get, uri)
                 .with(headers: headers)
                 .to_return(status: 404, body: error_response.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})
          begin
            Cb::Clients::SavedJobs.get(id: 'id', oauth_token: 'token')
            expect(false).to eq(true)
          rescue Cb::DocumentNotFoundError => error
            expect_api_to_error(error, stub)
          end
        end
      end
    end

    context '#delete' do
      let(:uri) { "https://api.careerbuilder.com/consumer/saved-jobs/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

      context 'asking for a specific saved job' do
        let(:data) { ['The saved job was deleted successfully'] }

        it 'performs a get and returns the coverletter asked for' do
          stub = stub_request(:delete, uri)
          .with(headers: headers)
          .to_return(status: 200, body: response.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})

          response = Cb::Clients::SavedJobs.delete(id: 'id', oauth_token: 'token')
          expect_api_to_succeed_and_return_model(response, stub)
        end
      end

      context 'when an error occurs' do
        let(:data) { [{ 'type' => '500', 'message' => 'Could not find the saved job specified', 'code' => '404' }] }

        it 'returns the error hash' do
          stub = stub_request(:delete, uri)
          .with(headers: headers)
          .to_return(status: 500, body: error_response.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})

          begin
            Cb::Clients::SavedJobs.delete(id: 'id', oauth_token: 'token')
            expect(false).to eq(true)
          rescue Cb::ServerError => error
            expect_api_to_error(error, stub)
          end
        end
      end
    end

    context '#update' do
      let(:post_data) { { 'id' => 'id', 'notes' => 'notes' } }
      let(:uri) { "https://api.careerbuilder.com/consumer/saved-jobs/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

      context 'when updating an existing saved job' do
        it 'performs a post and returns the updated coverletter asked for' do
          stub = stub_request(:post, uri)
          .with(body: post_data.to_json, headers: headers)
          .to_return(status: 200, body: response.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})

          response = Cb::Clients::SavedJobs.update(id: 'id', notes: 'notes', oauth_token: 'token')
          expect_api_to_succeed_and_return_model(response, stub)
        end
      end

      context 'when an error occurs' do
        let(:data) { [{ 'type' => '500', 'message' => 'Could not find the saved job specified', 'code' => '404' }] }

        it 'returns the error hash' do
          stub = stub_request(:post, uri)
          .with(body: post_data.to_json, headers: headers)
          .to_return(status: 500, body: error_response.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})
          begin
            Cb::Clients::SavedJobs.update(id: 'id', notes: 'notes', oauth_token: 'token')
            expect(false).to eq(true)
          rescue Cb::ServerError => error
            expect_api_to_error(error, stub)
          end
        end
      end
    end
  end
end
