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
  describe Responses::ApplicationExternal::SubmitApplication do
    let(:json_hash) do
      { 'Errors' => nil,
        'ApplyUrl' => 'website.com'
      }
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        expect(Responses::ApplicationExternal::SubmitApplication.new(json_hash).class).to eq Responses::ApplicationExternal::SubmitApplication
      end

      it 'instantiates new model objects' do
        response = Responses::ApplicationExternal::SubmitApplication.new(json_hash)

        expect(response.model.apply_url).to eq('website.com')
      end
    end
  end
end
