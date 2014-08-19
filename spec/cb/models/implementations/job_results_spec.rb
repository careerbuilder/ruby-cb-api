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

          it 'sets search_location to the first one' do
            results = JobResults.new(results_hash, {})
            expect(results.search_location).to eq search_location[0]
          end
        end
      end
    end
  end
end
