# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
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
