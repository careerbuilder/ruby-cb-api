require 'spec_helper'

module Cb
  module Responses
    describe ResumeDataListResponse do

      let(:response_stub) { file }
      let(:file) { JSON.parse(File.read('spec/support/response_stubs/resume_education.json')) }

      context 'missing node TotalResults' do
        let(:total_results) { 'TotalResults' }

        before do
          response_stub.delete(total_results)
        end
        it do
          expect { Cb::Responses::ResumeDataListResponse.new(response_stub) }
          .to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
            expect(ex.message).to include total_results
          end
        end
      end

      context 'missing node TotalResults' do
        let(:returned_results) { 'ReturnedResults' }

        before do
          response_stub.delete(returned_results)
        end
        it do
          expect { Cb::Responses::ResumeDataListResponse.new(response_stub) }
          .to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
            expect(ex.message).to include returned_results
          end
        end
      end

      context 'does not implement extract_models' do
        it do
          expect { Cb::Responses::ResumeDataListResponse.new(response_stub) }
          .to raise_error(NotImplementedError) do |ex|
            expect(ex.message).to include 'extract_models'
          end
        end
      end
    end
  end
end
