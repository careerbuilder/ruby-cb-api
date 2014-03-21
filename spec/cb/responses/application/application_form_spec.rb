require 'spec_helper'

describe Cb::Responses::ApplicationForm do
  let(:response_stub) { JSON.parse(File.read('spec/support/response_stubs/application_form.json')) }

  context 'when the API response comes back as expected' do
    it 'contains application form models' do
      response = Cb::Responses::ApplicationForm.new(response_stub)
      expect(response.models.first).to be_an_instance_of Cb::Models::Application::Form
    end
  end

  context 'when missing the Results field' do
    it 'raises an exception' do
      response_stub.delete('Results')

      expect{Cb::Responses::ApplicationForm.new(response_stub)}.
        to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
          expect(ex.message).to include 'Results'
      end
    end
  end
end
