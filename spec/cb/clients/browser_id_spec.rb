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
  describe Cb::Clients::BrowserID do
    include_context :stub_api_following_standards

    let(:uri) {"https://api.careerbuilder.com/consumer/browser-id?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }
    let(:data) { ['X1D1ED1AB1C2E2ACB376040B85C9CA434932CB4DB65BA1F3E7ABF98C2F08A384F471F98FEC9F8ADD9788DE91F3E6DD4E84'] }

    context '#get' do
      it 'performs a get and returns the browser id' do
        stub = stub_request(:get, uri).
            with(:headers => headers).
            to_return(:status => 200, :body => response.to_json)

        response = Cb::Clients::BrowserID.get(oauth_token: 'token')
        expect_api_to_succeed_and_return_model(response, stub)
      end
    end
  end
end
