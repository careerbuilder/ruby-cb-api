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
module Cb
  describe Responses::Errors do
    before(:all) { @errors = ['much awesome', 'so api', 'wow'] }

    context '#new' do
      let(:parsed_error_response) { 'much awesome,so api,wow' }

      def self.run_specs
        context 'and the optional boolean arg is omitted' do
          it 'raises an api error since an error was found' do
            expect do
              Responses::Errors.new(@errors_hash)
            end.to raise_error ApiResponseError
          end
        end

        context 'and the optional boolean arg is included, set to false' do
          it 'initializes a-ok' do
            Responses::Errors.new(@errors_hash, false)
          end
        end

        context 'and the optional boolean arg is included, set to true' do
          it 'raises an api error since an error was found' do
            expect do
              Responses::Errors.new(@errors_hash, true)
            end.to raise_error ApiResponseError
          end
        end

        it 'assigns correct value to @parse' do
          expect(Responses::Errors.new(@errors_hash, false).parsed).eql? parsed_error_response
        end
      end

      context 'when passed a hash with "errors" node as a hash' do
        before(:all) { @errors_hash = { 'errors' => { 'error' => @errors } } }
        run_specs
      end

      context 'when passed a hash with "error" node as an array' do
        before(:all) { @errors_hash =  { 'error' => @errors } }
        run_specs
      end
    end

    before(:all) { @errors_hash = { 'errors' => { 'error' => @errors } } }

    context '#parsed' do
      it 'returns an enumerable of strings' do
        errors = Responses::Errors.new(@errors_hash, false)
        expect(errors.parsed.respond_to?(:[]))   .to eq true
        expect(errors.parsed.respond_to?(:count)).to eq true
        expect(errors.parsed.respond_to?(:map))  .to eq true
      end
    end

    context 'any missing method' do
      it 'works as if Errors is enumerable' do
        errors = Responses::Errors.new(@errors_hash, false)
        errors.first
        errors.map
        errors.count
        errors.pop
      end
    end
  end
end
