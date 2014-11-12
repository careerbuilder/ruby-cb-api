require 'spec_helper'

module Cb
  module Requests
    describe DataLists::CountryCodes do
      subject { DataLists::CountryCodes.new({}) }

      let(:headers) {
        {
            'DeveloperKey' => Cb.configuration.dev_key,
            'Content-Type' => 'application/xml'
        }
      }

      it { expect(subject.endpoint_uri).to eql Cb.configuration.uri_country_codes }
      it { expect(subject.headers).to eql headers}
      it { expect(subject.http_method).to eql :get }
      it { expect(subject.body).to eql nil}

    end
  end
end