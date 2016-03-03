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
    let(:content) { { ResponseEmployeeTypes: { Errors: 'null', CountryCode: 'US', TimeResponseSent: '4/1/2014 5:08:10 PM', EmployeeTypes: { EmployeeType: [{ Code: 'ETFT', Name: { '@language' => 'en', '#text' => 'Full Time' } }, { Code: 'ETPT', Name: { '@language' => 'en', '#text' => 'Part Time' } }] } } } }

    context 'search' do
      it 'returns an array of industry codes' do
        stub_request(:get, 'https://api.careerbuilder.com/v1/employeetypes?developerkey=mydevkey&outputjson=true').
            with(:headers => {'Accept-Encoding'=>'deflate, gzip', 'Developerkey'=>'mydevkey'}).
            to_return(status: 200, body: content.to_json)
        response = Cb.employee_types.search
        expect(response.models.first).to be_an_instance_of(Cb::Models::EmployeeType)
      end
    end

    context 'search_by_hostsite' do
      it 'returns an array of industry codes' do
        stub_request(:get, 'https://api.careerbuilder.com/v1/employeetypes?CountryCode=FR&developerkey=mydevkey&outputjson=true').
            with(:headers => {'Accept-Encoding'=>'deflate, gzip', 'Developerkey'=>'mydevkey'}).
            to_return(status: 200, body: content.to_json)
        response = Cb.employee_types.search_by_hostsite('FR')
        expect(response.models.first).to be_an_instance_of(Cb::Models::EmployeeType)
      end
    end
  end
end
