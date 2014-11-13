require 'spec_helper'

module Cb
  module Responses
    describe ResumeEducation do
      subject { ResumeEducation.new(response_stub) }

      let(:response_stub) { file }
      let(:file) { JSON.parse(File.read('spec/support/response_stubs/resume_education.json')) }

      it { expect(subject.model.first).to be_an_instance_of(Cb::Models::DataLists::ResumeEducation) }
      it { expect(subject.model.first.key).to eql('ce3101') }
      it { expect(subject.model.first.value).to eql('Vocational High School') }

    end
  end
end
