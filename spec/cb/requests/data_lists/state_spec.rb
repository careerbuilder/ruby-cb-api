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
  describe Cb::Requests::State::Get do
    describe '#new' do
      context 'without arguments' do
        let(:request) { Cb::Requests::State::Get.new({}) }
        let(:query) do
          {
            countryCode: nil,
            outputjson: true
          }
        end

        it { expect(request.endpoint_uri).to eq Cb.configuration.uri_state_list }
        it { expect(request.http_method).to eq :get }
        it { expect(request.query).to eq(query) }
        it { expect(request.body).to eq nil }
        it { expect(request.base_uri).to eq 'https://www.careerbuilder.com' }
      end

      context 'with arguments' do
        let (:request) do
          Cb::Requests::State::Get.new(country_code: 'GR')
        end
        let(:query) do
          {
            countryCode: 'GR',
            outputjson: true
          }
        end

        it { expect(request.endpoint_uri).to eq(Cb.configuration.uri_state_list) }
        it { expect(request.http_method).to eq :get }
        it { expect(request.query).to eq (query) }
        it { expect(request.body).to eq nil }
      end
    end
  end
end
