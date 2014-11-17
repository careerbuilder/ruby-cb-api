require 'spec_helper'

module Cb
  module Responses
    describe CountryCodes do
      let(:response_stub) { file }
      let(:file) { MultiXml.parse(File.read('spec/support/response_stubs/country_codes.xml')) }
      let(:response) { Cb::Responses::CountryCodes.new(response_stub) }

      it { expect(response.models.first).to be_an_instance_of(Cb::Models::CountryCode) }
      it { expect(response.models.first.code).to eql('US') }

      context 'missing node SupportedCountryCodes' do
        before do
          response_stub['ResponseCountryCodes'].delete('SupportedCountryCodes')
        end
        it do
          expect { Cb::Responses::CountryCodes.new(response_stub) }
              .to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
            expect(ex.message).to include 'SupportedCountryCodes'
          end
        end
      end

      context 'missing node CountryCode' do
        before do
          response_stub['ResponseCountryCodes']['SupportedCountryCodes'].delete('CountryCode')
        end
        it do
          expect { Cb::Responses::CountryCodes.new(response_stub) }
              .to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
            expect(ex.message).to include 'CountryCode'
          end
        end
      end
    end
  end
end
