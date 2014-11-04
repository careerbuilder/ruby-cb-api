require 'spec_helper'

module Cb
  describe Clients::LanguageCodes do
    describe '#codes' do

      let(:json_response) { JSON.parse(File.read('spec/support/response_stubs/language_codes.json')) }

      before(:each) do
        stub_request(:get, uri_stem(Cb.configuration.uri_resume_language_codes)).
            to_return(body: json_response.to_json)
      end

      it 'returns an array of language codes' do
        response = Cb.language_codes.codes
        expect(response.models.first).to be_an_instance_of(Cb::Models::Resumes::LanguageCode)
      end

    end
  end
end