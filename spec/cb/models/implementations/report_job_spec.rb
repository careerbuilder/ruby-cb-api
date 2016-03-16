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
  describe Models::ReportJob do

    shared_examples_for 'report job' do
      let(:model) { Cb::Models::ReportJob.new({ 'Success' => status }) }

      it { expect(model.success).to eql(status) }
    end

    context 'status is true' do
      let(:status) { true }
      it_behaves_like 'report job'
    end

    context 'status is false' do
      let(:status) { false }
      it_behaves_like 'report job'
    end
  end
end
