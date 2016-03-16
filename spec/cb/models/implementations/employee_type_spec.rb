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
module Cb
  describe Models::EmployeeType do
    context '#new' do
      context 'when there is no input supplied' do
        def new_model
          Cb::Models::EmployeeType.new
        end

        it 'initializes with no args to empty string defaults' do
          expect(new_model.code).    to eq ''
          expect(new_model.name).    to eq ''
          expect(new_model.language).to eq ''
        end
      end

      context 'when the input hash has the correct fields' do
        def new_model(hash)
          Cb::Models::EmployeeType.new(hash)
        end

        let(:populated_input) do
          { 'Code' => 'whoa', 'Name' => { '#text' => 'weird', '@language' => 'formatting' } }
        end

        it 'initializes with the values of those fields' do
          expect(new_model(populated_input).code).    to eq 'whoa'
          expect(new_model(populated_input).name).    to eq 'weird'
          expect(new_model(populated_input).language).to eq 'formatting'
        end
      end
    end
  end
end
