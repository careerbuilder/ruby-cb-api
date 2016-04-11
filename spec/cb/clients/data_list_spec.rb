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
  describe Cb::Clients::DataList do
    include_context :stub_api_following_standards

    let(:uri) { 'https://api.careerbuilder.com/consumer/datalist/countries?countrycode=US&developerkey=mydevkey&outputjson=true' }
    let(:data) { [JSON.parse( File.read('spec/support/response_stubs/data_list_countries.json'))] }
    let(:stub) { stub_request(:get, uri).with(headers: headers).to_return(status: 200, body: response.to_json) }
    subject { Cb::Clients::DataList.get(oauth_token: 'token', country_code: 'US', list: 'countries') }

    before do
      stub
      subject
    end
    context '#get' do
      it { expect_api_to_succeed_and_return_model(subject, stub) }
    end
  end
end
