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

module Cb
  describe Cb::Config do
    context '.to_hash' do
      it 'should return a hash' do
        config = Cb.configuration

        expect(config.is_a?(Cb::Config)).to eq(true)
        expect(config.to_hash.is_a?(Hash)).to eq(true)
      end
    end
    context 'defaults' do
      it 'should have a base_uri' do
        config = Cb.configuration
        expect(config.base_uri).not_to be_nil
      end
      it 'should have a base_uri with https' do
        config = Cb.configuration
        expect(config.base_uri[0..4]).to eq('https')
      end
    end
    context 'uri' do
      it 'should change base_uri' do
        uri = 'hello world'
        config = Cb.configuration
        default_uri = config.base_uri

        config.set_base_uri(uri)
        expect(config.base_uri).to eq(uri)

        config.set_base_uri(default_uri)
        expect(config.base_uri).to eq(default_uri)
      end
    end
  end
end
