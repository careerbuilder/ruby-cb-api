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
  describe Clients::Industry do
    describe '#search' do
      before(:each) do
        content = { ResponseIndustryCodes: { Errors: 'null', CountryCode: 'US', TimeResponseSent: '4/1/2014 5:08:10 PM', IndustryCodes: { IndustryCode: [{ Code: 'IND067', Name: { '@language' => 'en', '#text' => 'Accounting - Finance' } }, { Code: 'IND001', Name: { '@language' => 'en', '#text' => 'Advertising' } }] } } }

        stub_request(:get, uri_stem(Cb.configuration.uri_job_industry_search))
          .to_return(body: content.to_json)
      end

      context 'search' do
        it 'returns an array of industry codes' do
          response = Cb.industry.search
          expect(response.models.first).to be_an_instance_of(Cb::Models::Industry)
        end
      end
    end
  end
end
