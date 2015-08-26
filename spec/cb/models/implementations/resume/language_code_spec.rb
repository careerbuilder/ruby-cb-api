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
  describe Models::LanguageCode do
    describe '#new' do
      let(:key_name) { 'Name' }
      let(:name) { 'name' }
      let(:key_code) { 'Code' }
      let(:code) { 'code' }

      let(:error) do
        begin
          language_code
        rescue ExpectedResponseFieldMissing => e
          e.message
        end
      end

      context 'given Name and Code' do
        let(:args) { { key_name => name, key_code => code } }
        let(:language_code) { Models::LanguageCode.new(args) }

        it { expect(language_code.name).to eq(name) }
        it { expect(language_code.code).to eq(code) }
      end

      context 'missing both arguments' do
        let(:language_code) { Models::LanguageCode.new({}) }

        it { expect(error).to eq(key_code + ' ' + key_name) }
      end

      context 'missing Code' do
        let(:language_code) { Models::LanguageCode.new(key_name => name) }

        it { expect(error).to eq(key_code) }
      end

      context 'missing Name' do
        let(:language_code) { Models::LanguageCode.new(key_code => code) }

        it { expect(error).to eq(key_name) }
      end
    end
  end
end
