# Copyright 2017 CareerBuilder, LLC
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
  describe Clients::Base do
    context '::cb_client' do
      it 'returns an instance of Cb::Utils::Api' do
        expect(Cb::Clients::Base.cb_client).to be_a Cb::Utils::Api
      end
    end

    context '::headers' do
      it 'returns a hash of headers including Bearer token Authorization' do
        headers = Cb::Clients::Base.headers(oauth_token: 'best_token')
        expect(headers['Authorization']).to eq 'Bearer best_token'
      end

      it 'defaults Accept to application/json' do
        headers = Cb::Clients::Base.headers()
        expect(headers['Accept']).to eq 'application/json'
      end

      it 'accepts an optional param to change Accept header' do
        headers = Cb::Clients::Base.headers(accept_header: 'application/json;version=1.1')
        expect(headers['Accept']).to eq 'application/json;version=1.1'
      end

      it 'defaults Content-Type to application/json' do
        headers = Cb::Clients::Base.headers()
        expect(headers['Content-Type']).to eq 'application/json'
      end
    end
  end
end
