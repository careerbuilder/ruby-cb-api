# Copyright 2016 CareerBuilder, LLC
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
    describe DataLists::Countries do
      subject { DataLists::Countries.new(token, args) }

      let(:token) { double('token') }
      let(:args) { { 'arg_1' => 'arg1', 'arg_2' => 'arg2' } }
      let(:uri) { 'https://api.careerbuilder.com/consumer/datalist/countries?countrycode=US' }
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

      it { expect(subject.api_uri).to eq '/consumer/datalist/countries' }
      it { expect(token).to receive(:get).with(uri) }

      context 'when country code is set' do
        let(:args) { { 'countrycode' => 'GR' } }
        let(:uri) { 'https://api.careerbuilder.com/consumer/datalist/countries?countrycode=GR' }

        it { expect(token).to receive(:get).with(uri) }
      end
    end
  end
end
