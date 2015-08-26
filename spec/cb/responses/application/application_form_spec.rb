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

      expect { Cb::Responses::ApplicationForm.new(response_stub) }
        .to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
        expect(ex.message).to include 'Results'
      end
    end
  end
end
