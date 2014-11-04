require 'spec_helper'

module Cb
  describe Cb::Requests::Resumes::LanguageCodes do
    let(:headers) {
      {
          'DeveloperKey' => Cb.configuration.dev_key,
          'Content-Type' => 'application/json'
      }
    }

    describe '#new' do
      context 'without arguments' do
        let(:args) {{}}
        let(:request) { Cb::Requests::Resumes::LanguageCodes.new(args) }
        let(:default_country_code) { 'US' }

        it { expect(request.endpoint_uri).to eq Cb.configuration.uri_resume_language_codes }
        it { expect(request.http_method).to eq :get }
        it { expect(request.query).to eq({ countryCode: default_country_code }) }
        it { expect(request.headers).to eq headers }
        it { expect(request.body).to eq nil }
      end

      context 'with arguments' do
        let (:country_code) { 'GR' }
        let (:request) { Cb::Requests::Resumes::LanguageCodes.new({ countryCode: country_code }) }

        it { expect(request.endpoint_uri).to eq Cb.configuration.uri_resume_language_codes }
        it { expect(request.http_method).to eq :get }
        it { expect(request.query).to eq ({ countryCode: country_code }) }
        it { expect(request.headers).to eq headers }
        it { expect(request.body).to eq nil }
      end
    end
  end
end
