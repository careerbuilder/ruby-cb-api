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
  describe Requests::Job::Report do
    let(:request) { described_class.new({}) }
    let(:endpoint) { '/v1/job/report' }

    it { expect(request.http_method).to eql(:post) }
    it { expect(request.endpoint_uri).to eql(endpoint) }
  end
end
