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
  describe Responses::EmployeeTypes::Search do
    let(:json_hash) do
      { 'ResponseEmployeeTypes' => {
        'EmployeeTypes' => {
          'EmployeeType' => [{ 'whoa' => 'nelly' }]
          }
        }
      }
    end

    before(:each) do
      allow(Responses::Metadata).to receive(:new)
      allow(Models::EmployeeType).to receive(:new)
    end

    context '#new' do
      it 'returns an employee types response object' do
        expect(Responses::EmployeeTypes::Search.new(json_hash).class).to eq Responses::EmployeeTypes::Search
      end

      it 'instantiates new model objects' do
        expect(Models::EmployeeType).to receive(:new)
        Responses::EmployeeTypes::Search.new(json_hash)
      end

      context 'when input response hash cannot be validated due to' do
        def expect_response_field_error
          expect { Responses::EmployeeTypes::Search.new(json_hash) }.to raise_error ExpectedResponseFieldMissing
        end

        context 'missing root node' do
          let(:json_hash) { { 'yey' => 'wow' } }

          it 'raises an error' do
            expect_response_field_error
          end
        end

        context 'missing EmployeeTypes node' do
          let(:json_hash) { { 'ResponseEmployeeTypes' => {} } }

          it 'raises an error' do
            expect_response_field_error
          end
        end

        context 'missing EmployeeType node' do
          let(:json_hash) { { 'ResponseEmployeeTypes' => { 'EmployeeTypes' => {} } } }

          it 'raises an error' do
            expect_response_field_error
          end
        end
      end
    end

    context '#models' do
      it 'each hash in the array under EmployeeType node makes a model' do
        hash_count = json_hash['ResponseEmployeeTypes']['EmployeeTypes']['EmployeeType'].count
        model_count = Responses::EmployeeTypes::Search.new(json_hash).models.count
        expect(model_count).to eq hash_count
      end
    end
  end
end
