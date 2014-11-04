require 'spec_helper'

module Cb
  describe Models::Resumes::LanguageCode do
    describe '#new' do
      let(:key_name) { 'Name' }
      let(:name) { 'name' }
      let(:key_code) { 'Code' }
      let(:code) { 'code' }

      let(:error) do
        begin
          response
        rescue ExpectedResponseFieldMissing => e
          e.message
        end
      end

      context 'given Name and Code' do
        let(:args) { { key_name => name , key_code => code} }
        let(:language_code_model) { Models::Resumes::LanguageCode.new(args) }

        it { expect(language_code_model.name).to eq(name) }
        it { expect(language_code_model.code).to eq(code) }
      end

      context 'missing both arguments' do
        let(:response) { Models::Resumes::LanguageCode.new({}) }

        it { expect(error).to eq(key_code + ' ' + key_name) }
      end

      context 'missing Code' do
        let(:response) { Models::Resumes::LanguageCode.new({ key_name => name }) }

        it { expect(error).to eq(key_code) }
      end

      context 'missing Name' do
        let(:response) { Models::Resumes::LanguageCode.new({ key_code => code }) }

        it { expect(error).to eq(key_name) }
      end
    end
  end
end
