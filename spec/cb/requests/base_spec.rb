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
  describe Cb::Requests::Base do
    context 'initialize' do
      it 'should have unimplemented errors' do
        base = Cb::Requests::Base.new({})
        expect { base.endpoint_uri }.to raise_error(NotImplementedError)
        expect { base.http_method }.to raise_error(NotImplementedError)
      end
      it 'should have error when not given a hash' do
        expect { Cb::Requests::Base.new('') }.to raise_error(ArgumentError)
      end
    end
  end
end
