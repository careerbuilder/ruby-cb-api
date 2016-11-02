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

    describe '#get' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_job_find))
          .to_return(body: { ResponseJob: { Job: {} } }.to_json)
      end

      let(:args) { { did: 'someDID'} }

      it 'returns a hash' do
        response = Cb::Clients::Job.get(args)
        expect(response).to be_a Hash
      end
    end
  end
end
