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
  describe Clients::EmployeeTypes do
    before(:each) do
      allow(cb_api_client).to receive(:cb_get).and_return('bananas' => '4life')
      allow(Cb.api_client).to receive(:new).and_return(cb_api_client)
      response = double(Responses::EmployeeTypes::Search)
      allow(response).to receive(:class).and_return Responses::EmployeeTypes::Search
      allow(Responses::EmployeeTypes::Search).to receive(:new).and_return(response)
    end

    def returns_response_object(method, *args)
      response = client_under_test.send(method, *args)
      expect(response.class).to eq Responses::EmployeeTypes::Search
    end

    context '#search' do
      it 'calls the employee types endpoint' do
        endpoint_url = Cb.configuration.uri_employee_types
        expect(cb_api_client).to receive(:cb_get).with(endpoint_url)
        client_under_test.search
      end

      it 'returns a response object' do
        returns_response_object(:search)
      end
    end

    context '#search_by_hostsite' do
      it 'calls the employee types endpoint with hostsite query string' do
        endpoint_url = Cb.configuration.uri_employee_types
        hostsite = 'de'
        query = { query: { CountryCode: hostsite } }
        expect(cb_api_client).to receive(:cb_get).with(endpoint_url, query)
        client_under_test.search_by_hostsite(hostsite)
      end

      it 'returns a response object' do
        returns_response_object(:search_by_hostsite, 'us')
      end
    end
  end
end
