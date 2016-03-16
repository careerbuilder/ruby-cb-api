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
    describe ResumeDataList do
      subject { ResumeDataList.new(args) }
      let(:key) { 'key' }
      let(:value) { 'value' }

      let(:error) do
        begin
          subject
        rescue ExpectedResponseFieldMissing => e
          e.message
        end
      end

      context 'valid arguments' do
        let(:args) { { key => key, value => value } }

        it { expect(subject.key).to eql(key) }
        it { expect(subject.value).to eql(value) }
      end

      context 'invalid key' do
        let(:args) { { 'invalid_key' => key, value => value } }

        it { expect(error).to eq(key) }
      end

      context 'invalid value' do
        let(:args) { { key => key, 'invalid_value' => value } }

        it { expect(error).to eq(value) }
      end

      context 'no args' do
        let(:args) { {} }

        it { expect(error).to eq(key + ' ' + value) }
      end
    end
  end
end
