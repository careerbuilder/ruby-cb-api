# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'spec_helper'

module Cb
  module Requests
    module DataLists
      describe DataListBase do
        let(:base) { Cb::Requests::DataLists::DataListBase }
        let(:token) { double('3Scale_token') }
        let(:args) { { 'countrycode' => 'GR' } }
        let(:made_base) { base.new(token, args) }
        let(:uri) { 'https://api.careerbuilder.com/url_piece?countrycode=GR' }

        describe '#new' do
          it { expect(made_base.token).to eq token }
          it { expect(made_base.args).to eq args }
        end

        describe '#get' do
          let(:response) { double('response') }
          let(:resume_data_list) { double(Cb::Responses::ResumeDataList) }
          let(:parsed_response) { double('parsed_response') }
          before do
            allow(made_base).to receive(:api_uri).and_return('/url_piece')
            allow(token).to receive(:get).and_return(response)
            allow(response).to receive(:parsed).and_return(parsed_response)
            allow(Cb::Responses::ResumeDataList).to receive(:new).and_return(resume_data_list)
          end
          it { expect(made_base.get).to be(resume_data_list) }
          it do
            expect(Cb::Responses::ResumeDataList).to receive(:new).with(parsed_response)
            made_base.get
          end

          it do
            expect(token).to receive(:get).with(uri)
            made_base.get
          end
        end

        describe 'api_uri' do
          it { expect { made_base.api_uri }.to raise_error(NotImplementedError) }
        end
      end
    end
  end
end
