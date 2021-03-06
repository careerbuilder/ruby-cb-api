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
  describe Cb::Clients::UserProfile do
    include_context :stub_api_following_standards

    let(:data) { [JSON.parse( File.read('spec/support/response_stubs/user_profile.json'))] }
    let(:uri) { "https://api.careerbuilder.com/consumer/user-profile?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }

    describe '#get' do
      it 'performs a get and returns the job report asked for' do
        stub = stub_request(:get, uri).
            with(:headers => headers).
            to_return(:status => 200, :body => response.to_json)

        response = Cb::Clients::UserProfile.get(oauth_token: 'token')
        expect_api_to_succeed_and_return_model(response, stub)
      end
    end
  end
end
