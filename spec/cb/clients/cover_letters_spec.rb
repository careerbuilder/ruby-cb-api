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
  describe Cb::Clients::CoverLetters do
    let(:data) { {id: 'id', name: 'name', text: 'text'} }
    let(:response) do
      {
          'data' => [
              data
          ],
          'page' => 1,
          'page_size' => 1,
          'total' => 1
      }
    end
    let(:headers) do
      {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'deflate, gzip',
          'Authorization'=>'Bearer token',
          'Developerkey'=>'ruby-cb-api'
      }
    end
    context '#create' do
      it 'performs a put with a coverletter in json format' do
        stub = stub_request(:put, "https://api.careerbuilder.com/consumer/coverletters?developerkey=ruby-cb-api&outputjson=true").
            with(:body => "{\"text\":\"text\",\"name\":\"name\"}",
                 :headers => headers).
            to_return(:status => 200, :body => response.to_json)
        response = Cb::Clients::CoverLetters.create(name: 'name', text: 'text', oauth_token: 'token')
        expect(stub).to have_been_requested
        expect(response.class).to eq(Hash)
        expect(response['data'].class).to eq(Array)
        expect(response['data'][0]).to eq(data)
      end

      
    end

  end
end
