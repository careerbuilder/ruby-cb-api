require 'spec_helper'

module Cb
  module Requests
    module DataLists
      describe Cb::Requests::DataLists::DataListBase do
        let(:base) { Cb::Requests::DataLists::DataListBase }
        let(:token) { double('3Scale_token') }
        let(:args) { {country_code: 'us' } }
        let(:made_base) { base.new(token, args) }

        describe '#new' do
          it { expect(made_base.token).to eq token }
          it { expect(made_base.args).to eq args }
        end

        describe '#get' do
          let(:response) { double('response') }
          let(:resume_data_list) { double(Cb::Responses::ResumeDataList) }
          let(:parsed_response) { double('parsed_response') }
          before do
            allow(made_base).to receive(:api_uri).and_return('url_piece')
            allow(token).to receive(:get).and_return(response)
            allow(response).to receive(:parsed).and_return(parsed_response)
            allow(Cb::Responses::ResumeDataList).to receive(:new).and_return(resume_data_list)
          end
          it { expect(made_base.get).to eq(resume_data_list) }
        end

        describe 'api_uri' do
          it { expect{ made_base.api_uri }.to raise_error(NotImplementedError) }
        end
      end
    end
  end
end