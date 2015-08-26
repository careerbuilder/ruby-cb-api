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
require 'cb/responses/user/retrieve'

module Cb
  describe Responses::User::Retrieve do
    let(:json_hash) do
      {
        'Errors' => '',
        'ResponseUserInfo' => {
          'Request' => 'HEY'
        }
      }
    end

    context '#new' do
      it 'returns a temp password response object' do
        expect(Responses::User::Retrieve.new(json_hash)).to be_an_instance_of Responses::User::Retrieve
      end

      context 'when input response hash cannot be validated due to' do
        context 'missing password node' do
          let(:json_hash) { { 'yey' => 'wow' } }

          it 'raises an error' do
            expect { Responses::User::Retrieve.new(json_hash) }
              .to raise_error ExpectedResponseFieldMissing
          end
        end
      end
    end

    context '#models' do
      it 'returns the TemporaryPassword node from the response' do
        response = Responses::User::Retrieve.new(json_hash)
        expect(response.model).to be_an_instance_of Cb::Models::User
      end
    end
  end
end
