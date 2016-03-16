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
  describe Responses::Industry::Search do
    let(:response) do
      { 'ResponseIndustryCodes' => {
        'IndustryCodes' => {
          'IndustryCode' => [{ 'like' => 'whoa' }]
        }
      }
      }
    end

    before(:each) do
      allow(Responses::Metadata).to receive(:new)
      allow(Models::Industry).to receive(:new)
    end

    context '#new' do
      it 'returns an industry response object' do
        expect(Responses::Industry::Search.new(response)).to be_instance_of(Responses::Industry::Search)
      end

      it 'instantiates new model objects' do
        expect(Models::Industry).to receive(:new)
        Responses::Industry::Search.new(response)
      end

      context 'when input response hash cannot be validated due to' do
        def expect_response_field_error
          expect { Responses::Industry::Search.new(response) }.to raise_error ExpectedResponseFieldMissing
        end

        context 'missing root node' do
          let(:response) { { 'herp' => 'derp' } }

          it 'raises an error' do
            expect_response_field_error
          end
        end

        context 'missing IndustryCodes node' do
          let(:response) { { 'ResponseIndustryCodes' => {} } }

          it 'raises an error' do
            expect_response_field_error
          end
        end

        context 'missing IndustryCode node' do
          let(:response) { { 'ResponseIndustryCodes' => { 'IndustryCodes' => {} } } }

          it 'raises an error' do
            expect_response_field_error
          end
        end
      end
    end

    context '#models' do
      it 'each hash in the array under IndustryCodes node makes a model' do
        hash_count = response['ResponseIndustryCodes']['IndustryCodes']['IndustryCode'].count
        model_count = Responses::Industry::Search.new(response).models.count
        expect(model_count).to eq(hash_count)
      end
    end
  end
end
