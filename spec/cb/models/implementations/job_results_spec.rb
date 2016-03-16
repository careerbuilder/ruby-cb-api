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

module Cb::Models
  describe JobResults do
    let(:search_response_hash) { YAML.load open('spec/support/response_stubs/search_result.yml') }
    let(:search_results) { JobResults.new(search_response_hash) }

    describe '#api_result' do
      context 'when search response is not a hash' do
        let(:search_response_hash) { [] }
        it { expect(search_results.api_response).to be_instance_of(Hash) }
      end
      
      context 'when search response is a hash' do
        it { expect(search_results.api_response).to be_instance_of(Hash) }
      end
      
      context 'when no search results are provided' do
        let(:search_results) { JobResults.new() }
        it { expect(search_results.api_response).to be_instance_of(Hash) }
      end
    end
  end
end
