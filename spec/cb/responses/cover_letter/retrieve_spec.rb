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
      describe Retrieve do
        let(:cb_cover_letter_retrieve_response) { described_class.new api_response }
        let(:api_response) { JSON.parse File.read('spec/support/response_stubs/cover_letter/retrieve.json') }

        it { expect(described_class).to be_a_subclass_of Cb::Responses::ApiResponse }

        describe '#model' do
          subject(:cover_letter) { cb_cover_letter_retrieve_response.model }

          it { is_expected.to be_a Cb::Models::CoverLetter }

          it { expect(cover_letter.id).to eq 'CLXXXXXXXXXXXXXXXXXX' }
          it { expect(cover_letter.name).to eq 'New Cover Letter' }
          it { expect(cover_letter.text).to eq 'Wow Im da bess.' }
          it { expect(cover_letter.created).to eq '9/18/2015 1:14:27 PM' }
          it { expect(cover_letter.modified).to eq '9/18/2015 1:14:27 PM' }
        end
      end
    end
  end
end
