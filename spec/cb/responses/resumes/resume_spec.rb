require 'spec_helper'

describe Cb::Responses::Resume do
  let(:response) { JSON.parse(File.read('spec/support/response_stubs/resume_get.json')) }

  context 'when the Api response comes back as expected' do
    let(:resumes) { Cb::Responses::Resume.new(response) }

    it { expect(resumes.models.first).to be_an_instance_of Cb::Models::Resume }
  end

  context 'when the Api response is missing the results field' do
    it 'raises an exception' do
      response.delete('Results')
      expect{ Cb::Responses::Resume.new(response) }.
        to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
          expect(ex.message).to include 'Results'
      end
    end
  end
end
