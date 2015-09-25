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
  describe Responses::Job::Report do
    let(:response) { described_class.new(json) }
    let(:json) do
      {
          'Errors' => [],
          'Success' => true
      }
    end

    it { expect(response.model.class).to eq(Cb::Models::ReportJob) }
    it { expect(response.model.success).to eq(true) }
    it { expect(response.hash_containing_metadata).to eq(json) }
  end

  context 'invalid args' do
    let(:json) do
      {
          'Errors' => []
      }
    end

    let(:error) { ExpectedResponseFieldMissing }

    it { expect { Responses::Job::Report.new(json) }.to raise_error error }
  end
end
