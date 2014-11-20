require 'spec_helper'

module Cb
  module Responses
    describe ResumeDataList do
      let(:subject) { ResumeDataList.new(response_stub) }
      let(:response_stub) { file }
      let(:file) { JSON.parse(File.read('spec/support/response_stubs/resume_education.json')) }

      context 'missing node TotalResults' do
        let(:total_results) { 'TotalResults' }

        before do
          response_stub.delete(total_results)
        end
        it do
          expect { Cb::Responses::ResumeDataList.new(response_stub) }
          .to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
            expect(ex.message).to include total_results
          end
        end
      end

      context 'missing node ReturnedResults' do
        let(:returned_results) { 'ReturnedResults' }

        before do
          response_stub.delete(returned_results)
        end
        it do
          expect { Cb::Responses::ResumeDataList.new(response_stub) }
          .to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
            expect(ex.message).to include returned_results
          end
        end
      end

      it { expect(subject.model.first).to be_an_instance_of(Cb::Models::ResumeDataList) }
      it { expect(subject.model.first.key).to eql('ce3101') }
      it { expect(subject.model.first.value).to eql('Vocational High School') }

    end
  end
end
