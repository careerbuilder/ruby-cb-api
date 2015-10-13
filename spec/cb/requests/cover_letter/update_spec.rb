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
    module CoverLetter
      describe Update do
        let(:cover_letter_update_request) { described_class.new args }

        let(:args) do
          {
            external_id: external_id,
            external_user_id: external_user_id,
            cover_letter_title: cover_letter_title,
            text: text,
            test: test
          }
        end

        let(:external_id) { 'external id' }
        let(:external_user_id) { 'external user id' }
        let(:cover_letter_title) { 'cover letter title' }
        let(:text) { 'text' }
        let(:test) { true }

        it { expect(described_class).to be_a_subclass_of Cb::Requests::Base }

        describe '#endpoint_uri' do
          subject { cover_letter_update_request.endpoint_uri }

          it { is_expected.to eq '/coverletter/edit' }
        end

        describe '#http_method' do
          subject { cover_letter_update_request.http_method }

          it { is_expected.to eq :post }
        end

        describe '#body' do
          subject { cover_letter_update_request.body }

          let(:expected_body) do
            <<-eos
            <Request>
              <DeveloperKey>#{ Cb.configuration.dev_key }</DeveloperKey>
              <ExternalID>#{ external_id }</ExternalID>
              <ExternalUserID>#{ args[:external_user_id] }</ExternalUserID>
              <CoverLetterTitle>#{ args[:cover_letter_title] }</CoverLetterTitle>
              <Text>#{ args[:text] }</Text>
              <Test>#{ expected_test }</Test>
            </Request>
            eos
          end

          let(:expected_test) { true }

          it { is_expected.to eq expected_body }

          context 'when test in args is nil' do
            let(:test) { nil }

            context 'expected test in body is false' do
              let(:expected_test) { false }

              it { is_expected.to eq expected_body }
            end
          end
        end
      end
    end
  end
end
