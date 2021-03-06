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
  module Models
    describe State do
      let(:state) { Models::State.new(state_hash) }

      context 'a state_hash is valid' do
        let(:state_hash) do
          {
            'StateId' => 'AL',
            'StateName' => 'Alabama'
          }
        end
        it { expect(state.key).to eq('AL') }
        it { expect(state.value).to eq ('Alabama') }
      end
    end
  end
end
