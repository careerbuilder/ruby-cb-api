require 'spec_helper'

module Cb
  describe Responses::Resumes::LanguageCodes do
    let(:response) { JSON.parse(File.read('spec/support/response_stubs/language_codes.json')) }

    context 'when the api response comes back as expected' do
      let(:codes) { Responses::Resumes::LanguageCodes.new(response) }
      it { expect(codes.models.first).to be_an_instance_of Models::Resumes::LanguageCode }
    end

    context 'when the Api response is missing the collection hash' do
      let(:language_codes) { 'LanguageCodes' }
      it 'raises an exception' do
        response["ResponseLanguageCodes"].delete(language_codes)
        expect{ Responses::Resumes::LanguageCodes.new(response) }.
            to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
          expect(ex.message).to include language_codes
        end
      end
    end
  end
end