require 'spec_helper'

module Cb
  module Requests
    describe DataLists::EducationCodes do
      subject { DataLists::EducationCodes.new(args) }

      let(:args) { {} }

      let(:headers) do
        {
            'DeveloperKey' => Cb.configuration.dev_key,
            'Content-Type' => 'application/json',
            'CountryCode' => 'US'
        }
      end

      it { expect(subject.endpoint_uri).to eql Cb.configuration.uri_resume_education }
      it { expect(subject.headers).to eql headers }
      it { expect(subject.http_method).to eql :get }
      it { expect(subject.body).to eql nil }

      context do
        let(:args) { { 'country_code' => 'GR' } }

        it { expect(subject.headers['CountryCode']).to eql 'GR' }
      end

    end
  end
end
