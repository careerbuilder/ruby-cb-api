require 'spec_helper'

module Cb
  module Requests
    describe DataLists::DesiredJobType do
      subject { DataLists::DesiredJobType.new(token, args) }

      let(:token) { double('token') }
      let(:args) { { 'arg_1' => 'arg1', 'arg_2' => 'arg2' } }
      let(:uri) { 'https://api.careerbuilder.com/consumer/datalist/desiredjobtype?countrycode=US' }
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

      it { expect(token).to receive(:get).with(uri) }

      context 'when countrycode is set' do
        let(:args) { { 'countrycode' => 'GR' } }
        let(:uri) { 'https://api.careerbuilder.com/consumer/datalist/desiredjobtype?countrycode=GR' }

        it { expect(token).to receive(:get).with(uri) }
        it { expect(subject.api_uri).to eq '/consumer/datalist/desiredjobtype'}
      end
    end
  end
end
