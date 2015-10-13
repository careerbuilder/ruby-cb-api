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
    module CoverLetter
      describe Update do
        let(:cb_cover_letter_update_response) { described_class.new api_response }
        let(:api_response) { JSON.parse File.read('spec/support/response_stubs/cover_letter/update.json') }

        it { expect(described_class).to be_a_subclass_of Cb::Responses::ApiResponse }

        describe '#models' do
          subject { cb_cover_letter_update_response.models }

          it { is_expected.to be nil }
        end

        describe '#status' do
          subject { cb_cover_letter_update_response.status }

          it { is_expected.to eq 'Success' }
        end
      end
    end
  end
end
