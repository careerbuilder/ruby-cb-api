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
  module Responses
    module CoverLetter
      describe List do
        let(:cb_cover_letter_list_response) { described_class.new api_response }

        it { expect(described_class).to be_a_subclass_of Cb::Responses::ApiResponse }

        describe '#models' do
          subject(:cover_letters) { cb_cover_letter_list_response.models }

          context 'when no cover letters are returned' do
            let(:api_response) { JSON.parse File.read('spec/support/response_stubs/cover_letter/list/none.json') }

            it { is_expected.to eq [] }
          end

          shared_examples_for :an_array_of_cb_models_cover_letter do
            it { cover_letters.each { |cover_letter| expect(cover_letter).to be_a Cb::Models::CoverLetter } }
          end

          context 'when one cover letter is returned' do
            let(:api_response) { JSON.parse File.read('spec/support/response_stubs/cover_letter/list/one.json') }

            it_behaves_like :an_array_of_cb_models_cover_letter

            context 'first cover letter' do
              let(:first_cover_letter) { cover_letters.first }

              it { expect(first_cover_letter.id).to eq 'CLXXXXXXXXXXXXXXXXXX' }
              it { expect(first_cover_letter.name).to eq 'One Cover Letter' }
              it { expect(first_cover_letter.text).to eq 'Wow Im da bess.' }
              it { expect(first_cover_letter.created).to eq '9/18/2015 1:14:27 PM' }
              it { expect(first_cover_letter.modified).to eq '9/18/2015 1:14:27 PM' }
            end
          end

          context 'when two cover letters are returned' do
            let(:api_response) { JSON.parse File.read('spec/support/response_stubs/cover_letter/list.json') }

            it_behaves_like :an_array_of_cb_models_cover_letter

            context 'first cover letter' do
              let(:first_cover_letter) { cover_letters.first }

              it { expect(first_cover_letter.id).to eq 'CLXXXXXXXXXXXXXXXXXX' }
              it { expect(first_cover_letter.name).to eq 'New Cover Letter' }
              it { expect(first_cover_letter.text).to eq 'Wow Im da bess.' }
              it { expect(first_cover_letter.created).to eq '9/18/2015 1:14:27 PM' }
              it { expect(first_cover_letter.modified).to eq '9/18/2015 1:14:27 PM' }
            end

            context 'last cover letter' do
              let(:last_cover_letter) { cover_letters.last }

              it { expect(last_cover_letter.id).to eq 'CLXXXXXXXXXXXXXXXXXX' }
              it { expect(last_cover_letter.name).to eq 'New Cover Letter 2' }
              it { expect(last_cover_letter.text).to eq 'Wow Im da bess. 2' }
              it { expect(last_cover_letter.created).to eq '9/18/2015 1:18:33 PM' }
              it { expect(last_cover_letter.modified).to eq '9/18/2015 1:18:33 PM' }
            end
          end
        end
      end
    end
  end
end
