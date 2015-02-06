require 'spec_helper'

module Cb
  # this class is meant to be inherited, behavior is demonstrated using dummy classes!
  describe Cb::Models::ApiResponseModel do

    describe '#new' do

      context 'when the inheriting class overrides all required methods' do
        class ValidDummyModel < Cb::Models::ApiResponseModel
          def required_fields
            %w(potatoes hotdogs baconbaconbacon)
          end

          def set_model_properties
            @stuff = api_response['potatoes'] || String.new
          end
        end

        context 'and the constructor-provided hash is valid' do
          it 'initializes without issue' do
            @api_response = { 'potatoes' => 1, 'hotdogs' => 2, 'baconbaconbacon' => 9001 }
            ValidDummyModel.new(@api_response)
          end
        end

        context 'but the constructor-provided hash is invalid' do
          it 'raises ExpectedResponseFieldMissing errors denoting which fields are missing' do
            @api_response = { 'no' => 'dice' }
            begin
              ValidDummyModel.new(@api_response)
              raise 'test should not have made it this far!'
            rescue ExpectedResponseFieldMissing => ex
              expect(ex.message.include?('potatoes hotdogs baconbaconbacon')).to eq true
            end
          end
        end
      end

      context 'when the inheriting class fails to overrides all required methods NotImplementedErrors are raised' do
        class FailDummyModel < Cb::Models::ApiResponseModel; end

        def assert_not_implemented_method_name(method_name, &expected_to_raise_error)
          begin
            expected_to_raise_error.call
            raise 'this test should not have made it this far!' # fail if proc code does not raise error
          rescue NotImplementedError => ex
            expect(ex.message.include?(method_name)).to eq true
          end
        end

        it '#required_fields' do
          assert_not_implemented_method_name('required_fields') { FailDummyModel.new }
        end

        it '#set_model_properties' do
          class FailDummyModel; def required_fields; Array.new end end
          assert_not_implemented_method_name('set_model_properties') { FailDummyModel.new }
        end
      end
    end # new

  end
end
