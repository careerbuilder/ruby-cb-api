require 'spec_helper'

module Cb
  module Models
    describe CountryCode do
      describe '#new' do
        let(:key) { 'CountryCode' }
        let(:value) { 'code' }
        let(:error_code) { 'CountryCode' }
        let(:country_code) { CountryCode.new(args) }

        let(:error) do
          begin
            country_code
          rescue ExpectedResponseFieldMissing => e
            e.message
          end
        end

        context 'no arguments' do
          let(:args) { {} }

          it { expect(error).to eql(error_code) }
        end

        context 'wrong argument' do
          let(:args) { {'blah' => 'blah'} }

          it { expect(error).to eql(error_code) }
        end

        context 'correct arguments' do
          let(:args) { { key => value } }

          it { expect(country_code.code).to eql(value) }
        end
      end
    end
  end
end