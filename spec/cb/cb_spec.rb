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

describe Cb do
  context '#configure' do
    context 'when called with a block' do
      it 'yields a default configuration to play with' do
        Cb.configure do |c|
          expect(c).to be_an_instance_of Cb::Config
        end
      end

      it 'caches the config if called again' do
        original_object_id = ''
        Cb.configure { |c1| original_object_id = c1.object_id }
        Cb.configure { |c2| expect(c2.object_id).to eq original_object_id }
      end
    end
  end
end
