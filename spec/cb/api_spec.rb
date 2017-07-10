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

describe Cb::Utils::Api do
  let(:api_util) { Cb::Utils::Api }
  
  context '#initialize' do
    it 'sets default gzip headers' do
      client = api_util.new
      expect(client.class.headers).to have_key('accept-encoding')
      expect(client.class.headers['accept-encoding']).to eq('deflate, gzip')
    end
  end
  
  context '#criteria_to_hash' do
    let(:criteria) { Cb::Criteria::User::ChangePassword.new({ external_id: 'something', old_password: 'old', new_password: 'new', test: 'true' }) }
    let(:hash) { { 'ExternalId' => 'something', 'OldPassword' => 'old', 'NewPassword' => 'new', 'Test' => 'true' } }

    it{ expect(api_util.criteria_to_hash(criteria)).to include(hash) }
  end
  
  context '#camelize' do
    let(:input) { 'external_id' }
    let(:output) { 'ExternalId' }
    
    it{ expect(api_util.camelize(input)).to eql(output) }
  end
end
