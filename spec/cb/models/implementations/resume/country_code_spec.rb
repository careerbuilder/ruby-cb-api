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
  module Models
    describe CountryCode do
      describe '#new' do
        let(:key) { 'CountryCode' }
        let(:value) { 'code' }
        let(:error_code) { 'CountryCode' }
        let(:country_code) { CountryCode.new(args) }

        let(:error) do
          begin
            country_code
          rescue ExpectedResponseFieldMissing => e
            e.message
          end
        end

        context 'no arguments' do
          let(:args) { {} }

          it { expect(error).to eql(error_code) }
        end

        context 'wrong argument' do
          let(:args) { { 'blah' => 'blah' } }

          it { expect(error).to eql(error_code) }
        end

        context 'correct arguments' do
          let(:args) { { key => value } }

          it { expect(country_code.code).to eql(value) }
        end
      end
    end
  end
end
