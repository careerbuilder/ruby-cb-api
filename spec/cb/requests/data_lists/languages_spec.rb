require 'spec_helper'

module Cb
  module Requests
    describe DataLists::Languages do
      subject { DataLists::Languages.new(token, args) }

      let(:token) { double('token') }
      let(:args) { { 'arg_1' => 'arg1', 'arg_2' => 'arg2' } }
      let(:uri) { 'https://api.careerbuilder.com/consumer/datalist/languages?countrycode=US' }
      let(:response) { double('response') }
      let(:parsed_response) { double('parsed_response') }
      let(:response_model) { double('response_model') }

      before do
        allow(token).to receive(:get).and_return(response)
        allow(response).to receive(:parsed).and_return(parsed_response)
        allow(Cb::Responses::ResumeDataList).to receive(:new).and_return(response_model)
      end

      after do
        subject.get
      end

      let(:args) { { 'country_code' => 'GR' } }
      let(:uri) { 'https://api.careerbuilder.com/consumer/datalist/languages?countrycode=GR' }

      it { expect(token).to receive(:get).with(uri) }
      it { expect(subject.get).to_not raise_error(NotImplementedError) }
      it { expect(subject.api_uri).to eq '/consumer/datalist/languages'}

    end
  end
end
