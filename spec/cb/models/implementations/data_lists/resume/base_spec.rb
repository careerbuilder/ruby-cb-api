require 'spec_helper'

module Cb
  module Models
    describe DataLists::DataListBase do
      subject { DataLists::DataListBase.new(args) }
      let(:key) { 'key' }
      let(:value) { 'value' }

      let(:error) do
        begin
          subject
        rescue ExpectedResponseFieldMissing => e
          e.message
        end
      end

      context 'valid arguments' do
        let(:args) { { key => key, value => value } }

        it { expect(subject.key).to eql(key) }
        it { expect(subject.value).to eql(value) }
      end

      context 'invalid key' do
        let(:args) { { 'invalid_key' => key, value => value } }

        it { expect(error).to eq(key) }
      end

      context 'invalid value' do
        let(:args) { { key => key, 'invalid_value' => value } }

        it { expect(error).to eq(value) }
      end

      context 'no args' do
        let(:args) { {} }

        it { expect(error).to eq(key + ' ' + value) }
      end
    end
  end
end
