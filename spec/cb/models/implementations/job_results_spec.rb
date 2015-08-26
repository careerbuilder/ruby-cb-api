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

module Cb::Models
  describe JobResults do
    describe '#initialize' do
      describe 'search_location' do
        let(:search_location) do
          { 'City' => 'Athens', 'StateCode' => 'B', 'CountryCode' => 'GR', 'PostalCode' => nil }
        end
        let(:results_hash) do
          {
            'SearchMetaData' => {
              'SearchLocations' => {
                'SearchLocation' => search_location
              }
            }
          }
        end

        it 'sets search_location to the SearchLocation in SearchMetaData' do
          results = JobResults.new(results_hash, {})
          expect(results.search_location).to eq search_location
        end

        context 'When there is more than one SearchLocation' do
          let(:search_location) do
            [
              { 'City' => 'Athens', 'StateCode' => 'B', 'CountryCode' => 'GR', 'PostalCode' => nil },
              { 'City' => 'Norcross', 'StateCode' => 'GA', 'CountryCode' => 'US', 'PostalCode' => nil }
            ]
          end

          it 'sets search_location to the array of them' do
            results = JobResults.new(results_hash, {})
            expect(results.search_location).to eq search_location
          end
        end
      end
    end
  end
end
