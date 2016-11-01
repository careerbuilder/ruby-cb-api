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
  describe Cb::Clients::Job do

    describe '#find_by_criteria' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_job_find))
          .to_return(body: { ResponseJob: { Job: {} } }.to_json)
      end

      let(:criteria) { Cb::Criteria::Job::Details.new }

      context 'when a criteria object is the input param' do
        it 'returns a hash' do
          expect(response.model).to be_a Hash
        end
      end
    end

    context '#find_by_did' do
      context 'when a string job did is input' do
        let(:criteria) { double(Cb::Criteria::Job::Details) }

        before(:each) { allow(Cb::Criteria::Job::Details).to receive(:new).and_return(criteria) }

        it 'constructs a criteria object, sets the input did, and calls #find_by_criteria' do
          did = 'fake-did'

          expect(Cb::Clients::Job).to receive(:find_by_criteria).with(criteria)
          expect(criteria).to receive(:did=).with(did)
          expect(criteria).to receive(:show_custom_values=).with(true)

          Cb::Clients::Job.find_by_did(did)
        end
      end
    end
  end
end
