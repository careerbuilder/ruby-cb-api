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

describe Cb::Responses::Recommendations do
  let(:response_hash) { JSON.parse(File.read('spec/support/response_stubs/recommendations_for_resume.json')) }
  let(:api_job_result_collection) { Cb::Responses::Recommendations.new(response_hash) }

  it { expect(api_job_result_collection.models.first).to be_an_instance_of Cb::Models::RecommendedJob }

  describe '#root_node' do
    it { expect(api_job_result_collection.root_node).to eq('data') }
  end

  context 'when the Api response is missing the results field' do
    let(:response_missing_data_node) { response_hash.delete('data') }
    let(:response) { Cb::Responses::Recommendations.new(response_missing_data_node) }

    it 'raises an exception' do
      expect { response }.to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
        expect(ex.message).to include 'data'
      end
    end
  end

  context 'when the Api response contains the nonstandard error message node "Message"' do
    let(:response_hash) do
      { 'Message' => 'Everything is terrible and the world hates you' }
    end

    it 'throws an ApiResponseError with the correct message' do
      expect { Cb::Responses::Recommendations.new(response_hash) }.to raise_error(Cb::ApiResponseError, response_hash['Message'])
    end
  end
end
