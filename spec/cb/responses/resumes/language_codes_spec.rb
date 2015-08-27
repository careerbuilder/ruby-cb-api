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
  module Responses
    describe LanguageCodes do
      let(:response_stub) { JSON.parse(File.read('spec/support/response_stubs/language_codes.json')) }
      let(:response) { Cb::Responses::LanguageCodes.new(response_stub) }

      it { expect(response.models.first).to be_an_instance_of(Cb::Models::LanguageCode) }

      context 'missing node LanguageCodes' do
        before do
          response_stub['ResponseLanguageCodes'].delete('LanguageCodes')
        end
        it do
          expect { Cb::Responses::LanguageCodes.new(response_stub) }
            .to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
            expect(ex.message).to include 'LanguageCodes'
          end
        end
      end

      context 'missing node LanguageCodes' do
        before do
          response_stub['ResponseLanguageCodes']['LanguageCodes'].delete('LanguageCode')
        end
        it do
          expect {Cb::Responses::LanguageCodes.new(response_stub)}.
              to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
            expect(ex.message).to include 'LanguageCode'
          end
        end
      end
    end
  end
end
