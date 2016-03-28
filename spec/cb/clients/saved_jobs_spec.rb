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
    let(:uri) {"https://api.careerbuilder.com/consumer/saved-jobs?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }
    let(:post_data) { {'job_id' => 'J1234567891234567890', 'notes' => 'these are my notes'} }
    let(:saved_job) do
      {
          'id' => 'id', 'job_id' => 'J1234567891234567890', 'notes' => 'these are my notes',
          'site' => 'US', 'status' => 'Saved',
          'created_data' => '2016-03-02T14:29:30.617998-05:00', 'modified_date' => '2016-03-02T14:29:30.617998-05:00',
          'job_expired' => 'false', 'job_expired_date' => '2017-03-28T03:29:27.367', 'application_date' => '1970-01-01T00:00:00'

      }
    end
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

    context '#create' do
      let(:data){ saved_job }
      context 'when posting succeeds' do
        it 'performs a put with a saved-job in json format' do
          stub = stub_request(:put, uri).
              with(:body => post_data.to_json, :headers => headers).
              to_return(:status => 200, :body => response.to_json)
          response = Cb::Clients::SavedJobs.create(job_id: 'J1234567891234567890', notes: 'these are my notes', oauth_token: 'token')
          expect(stub).to have_been_requested
          expect(response.class).to eq(Hash)
          expect(response['data'].class).to eq(Array)
          expect(response['data'][0]).to eq(data)
        end
      end

      context 'when there is an error' do
        let(:data) { { 'type' => '500', 'message' => 'Some kind of error happened', 'code' => '500' } }
        it 'returns the error hash' do
          stub_request(:put, uri).
              with(:body => post_data.to_json, :headers => headers).
              to_return(:status => 500, :body => error_response.to_json)
          response = Cb::Clients::SavedJobs.create(job_id: 'J1234567891234567890', notes: 'these are my notes', oauth_token: 'token')
          expect(response['errors'][0]).to eq(data)
        end
      end
    end

    context '#get' do
      context 'asking for all cover letters' do
        let(:data) { [saved_job,saved_job,saved_job] }
        it 'performs a get and returns the results hash' do
          stub = stub_request(:get, uri).
              with(:headers => headers).
              to_return(:status => 200, :body => response.to_json)

          response = Cb::Clients::SavedJobs.get(oauth_token: 'token')
          expect(stub).to have_been_requested
          expect(response.class).to eq(Hash)
          expect(response['data'].class).to eq(Array)
          expect(response['data'].length).to eq(3)
          expect(response['data'][0]).to eq(saved_job)
        end
      end

      context 'asking for a specific cover letter' do
        let(:data){ saved_job }
        let(:uri) { "https://api.careerbuilder.com/consumer/saved-jobs/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

        it 'performs a get and returns the coverletter asked for' do
          stub = stub_request(:get, uri).
              with(:headers => headers).
              to_return(:status => 200, :body => response.to_json)

          response = Cb::Clients::SavedJobs.get(id: 'id', oauth_token: 'token')
          expect(stub).to have_been_requested
          expect(response.class).to eq(Hash)
          expect(response['data'].class).to eq(Array)
          expect(response['data'].length).to eq(1)
          expect(response['data'][0]).to eq(saved_job)
        end
      end

      context 'when the cover letter is not found' do
        let(:data){ { 'type' => '404', 'message' => 'Could not find the cover letter specified', 'code' => '404' } }
        let(:uri) { "https://api.careerbuilder.com/consumer/saved-jobs/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

        it 'returns the error hash' do
          stub = stub_request(:get, uri).
              with(:headers => headers).
              to_return(:status => 404, :body => error_response.to_json)

          response = Cb::Clients::SavedJobs.get(id: 'id', oauth_token: 'token')
          expect(stub).to have_been_requested
          expect(response.class).to eq(Hash)
          expect(response['errors'].class).to eq(Array)
          expect(response['errors'].length).to eq(1)
          expect(response['errors'][0]).to eq(data)
        end
      end
    end

    context '#delete' do
      context 'asking for a specific cover letter' do
        let(:data){ 'The cover letter was deleted successfully' }
        let(:uri) { "https://api.careerbuilder.com/consumer/saved-jobs/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

        it 'performs a get and returns the coverletter asked for' do
          stub = stub_request(:delete, uri).
              with(:headers => headers).
              to_return(:status => 200, :body => response.to_json)

          response = Cb::Clients::SavedJobs.delete(id: 'id', oauth_token: 'token')
          expect(stub).to have_been_requested
          expect(response.class).to eq(Hash)
          expect(response['data'].class).to eq(Array)
          expect(response['data'].length).to eq(1)
          expect(response['data'][0]).to eq(data)
        end
      end

      context 'when an error occurs' do
        let(:data){ { 'type' => '500', 'message' => 'Could not find the cover letter specified', 'code' => '404' } }
        let(:uri) { "https://api.careerbuilder.com/consumer/saved-jobs/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

        it 'returns the error hash' do
          stub = stub_request(:delete, uri).
              with(:headers => headers).
              to_return(:status => 500, :body => error_response.to_json)

          response = Cb::Clients::SavedJobs.delete(id: 'id', oauth_token: 'token')
          expect(stub).to have_been_requested
          expect(response.class).to eq(Hash)
          expect(response['errors'].class).to eq(Array)
          expect(response['errors'].length).to eq(1)
          expect(response['errors'][0]).to eq(data)
        end
      end
    end

    context '#update' do
      let(:post_data) { {'id' => 'id','notes' => 'notes'} }
      context 'when updating an existing coverletter' do
        let(:data){ saved_job }
        let(:uri) { "https://api.careerbuilder.com/consumer/saved-jobs/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

        it 'performs a post and returns the updated coverletter asked for' do
          stub = stub_request(:post, uri).
              with(:body => post_data.to_json , :headers => headers).
              to_return(:status => 200, :body => response.to_json)

          response = Cb::Clients::SavedJobs.update(id: 'id',notes: 'notes', oauth_token: 'token')
          expect(stub).to have_been_requested
          expect(response.class).to eq(Hash)
          expect(response['data'].class).to eq(Array)
          expect(response['data'].length).to eq(1)
          expect(response['data'][0]).to eq(data)
        end
      end

      context 'when an error occurs' do
        let(:data){ { 'type' => '500', 'message' => 'Could not find the saved job specified', 'code' => '404' } }
        let(:uri) { "https://api.careerbuilder.com/consumer/saved-jobs/id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

        it 'returns the error hash' do
          stub = stub_request(:post, uri).
              with(:body => post_data.to_json, :headers => headers).
              to_return(:status => 500, :body => error_response.to_json)

          response = Cb::Clients::SavedJobs.update(id: 'id',notes: 'notes', oauth_token: 'token')
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
