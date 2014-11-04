require 'spec_helper'

module Cb
  describe Models::Resumes::LanguageCode do
    let(:error) do
      begin
        response
      rescue ExpectedResponseFieldMissing => e
        e.message
      end
    end

    context 'all arguments' do
      let(:key_name) { 'Name' }
      let(:name) { 'name' }
      let(:key_code) { 'Code' }
      let(:code) { 'code' }

      let(:args) { { key_name => name , key_code => code} }
      let(:language_code_model) { Models::Resumes::LanguageCode.new(args) }

      it { expect(language_code_model.name).to eq(name) }
      it { expect(language_code_model.code).to eq(code) }
    end

    context 'no arguments' do
      let(:error_message) { 'Code Name' }
      let(:response) { Models::Resumes::LanguageCode.new({}) }

      it { expect(error).to eq(error_message) }
    end

    context 'missing Code' do
      let(:key) { 'Name' }
      let(:value) { 'name' }
      let(:error_message) { 'Code' }
      let(:response) { Models::Resumes::LanguageCode.new({ key => value }) }

      it { expect(error).to eq(error_message) }
    end

    context 'missing Name' do
      let(:key) { 'Code' }
      let(:value) { 'code' }
      let(:error_message) { 'Name' }
      let(:response) { Models::Resumes::LanguageCode.new({ key => value }) }

      it { expect(error).to eq(error_message) }
    end


  end
end
