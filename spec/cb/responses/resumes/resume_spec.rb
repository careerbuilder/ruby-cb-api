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

describe Cb::Responses::Resume do
  let(:response) { JSON.parse(File.read('spec/support/response_stubs/resume_get.json')) }
  let(:resumes) { Cb::Responses::Resume.new(response) }
  context 'when the Api response comes back as expected' do
    it { expect(resumes.models.first).to be_an_instance_of Cb::Models::Resume }
  end

  describe '#status' do
    it { expect(resumes.status).to eq('Success') }
  end

  context 'when the Api response is missing the results field' do
    it 'raises an exception' do
      response.delete('Results')
      expect { Cb::Responses::Resume.new(response) }
        .to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
        expect(ex.message).to include 'Results'
      end
    end
  end
end
