require 'spec_helper'

module Cb
  describe Cb::Clients::Education do

    context '#get_for' do

      def stub_api_to_return(content)
        stub_request(:get, uri_stem(Cb.configuration.uri_education_code)).to_return(:body => content.to_json)
      end

      context 'when things are working correctly' do
        let(:mock_api) { double(Cb::Utils::Api) }

        before :each do
          allow(mock_api).to receive(:append_api_responses)
          allow(mock_api).to receive(:cb_get).and_return(Hash.new)
          allow(Cb::Utils::Api).to receive(:new).and_return(mock_api)
        end

        it 'calls #append_api_responses on the Cb API utility client' do
          expect(mock_api).to receive(:append_api_responses)
          Cb::Clients::Education.get_for('US')
        end

        it 'pings the education codes API endpoint with countrycode in the query string' do
          country_code = 'US'
          api_uri      = Cb.configuration.uri_education_code
          query_hash   = { :query => { :countrycode => country_code}}

          expect(mock_api).to receive(:cb_get).with(api_uri, query_hash)
          Cb::Clients::Education.get_for(country_code)
        end
      end

      context 'when the API response has all required nodes' do
        before :each do
          stub_api_to_return({ ResponseEducationCodes: { EducationCodes: { Education: [Hash.new]} } })
        end

        it 'returns an array of education models' do
          models = Cb::Clients::Education.get_for('US')
          expect(models).to       be_an_instance_of Array
          expect(models.first).to be_an_instance_of Cb::Models::Education
        end
      end

      context 'when the API response is missing nodes' do
        def expect_an_empty_array(thing)
          expect(thing).to be_an_instance_of Array
          expect(thing.empty?).to eq true
        end

        context '\ResponseEducationCodes' do
          before(:each) { stub_api_to_return(Hash.new) }

          it 'returns an empty array' do
            models = Cb::Clients::Education.get_for('US')
            expect_an_empty_array(models)
          end
        end

        context '\ResponseEducationCodes\EducationCodes' do
          before(:each) { stub_api_to_return({ ResponseEducationCodes: Hash.new }) }

          it 'returns an empty array' do
            models = Cb::Clients::Education.get_for('US')
            expect_an_empty_array(models)
          end
        end

        context '\ResponseEducationCodes\EducationCodes\Education' do
          before(:each) { stub_api_to_return({ ResponseEducationCodes: { EducationCodes: Hash.new } }) }

          it 'returns an empty array' do
            models = Cb::Clients::Education.get_for('US')
            expect_an_empty_array(models)
          end
        end

        context 'has \ResponseEducationCodes\EducationCodes\Education, but no content in it' do
          before(:each) { stub_api_to_return({ ResponseEducationCodes: { EducationCodes: { Education: nil } } }) }

          it 'raises a NoMethodError when #each is attempted' do
            expect { Cb::Clients::Education.get_for('US') }.to raise_error NoMethodError
          end
        end
      end

    end
  end
end
