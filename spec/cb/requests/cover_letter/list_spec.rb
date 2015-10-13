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
      describe List do
        let(:cover_letter_list_request) { described_class.new args }
        let(:args) { { external_user_id: external_user_id } }
        let(:external_user_id) { 'external user id' }

        it { expect(described_class).to be_a_subclass_of Cb::Requests::Base }

        describe '#endpoint_uri' do
          subject { cover_letter_list_request.endpoint_uri }

          it { is_expected.to eq '/v1/coverletter/list' }
        end

        describe '#http_method' do
          subject { cover_letter_list_request.http_method }

          it { is_expected.to eq :get }
        end

        describe '#query' do
          subject { cover_letter_list_request.query }

          it { is_expected.to eq ExternalUserId: external_user_id }
        end
      end
    end
  end
end
