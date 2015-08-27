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

module Cb::Models
  describe Job do
    describe '#initialize' do
      context 'When ApplyRequirements hash is contained in the hash passed into the constructor' do
        let(:job_hash) do
          { 'ApplyRequirements' => { 'ApplyRequirement' => 'noonlineapply' } }
        end

        it 'then the apply_requirements field should be set' do
          job = Job.new job_hash
          expect(job.apply_requirements).to eq(['noonlineapply'])
        end
      end
    end

    # if another 'boolean' field is added to the model with a matching predicate to go with, add it
    # to the set of mappings below and it will test itself for you!
    context 'predicate methods:' do
      response_to_model_mappings = [
        { api_field: 'HasQuestionnaire',    predicate_method: :has_questionnaire? },
        { api_field: 'CanBeQuickApplied',   predicate_method: :can_be_quick_applied? },
        { api_field: 'ManagesOthers',       predicate_method: :manages_others? },
        { api_field: 'IsScreenerApply',     predicate_method: :screener_apply? },
        { api_field: 'IsSharedJob',         predicate_method: :shared_job? },
        { api_field: 'RelocationCovered',   predicate_method: :relocation_covered? },
        { api_field: 'ExternalApplication', predicate_method: :external_application? }
      ]

      response_to_model_mappings.each do |mapping|
        response_field_name = mapping[:api_field]
        predicate_method = mapping[:predicate_method]

        context "#{response_field_name}/#{predicate_method}" do
          context 'when in response and set to (string) ' do
            context 'True' do
              it 'should respond true' do
                job_hash = { response_field_name => 'True' }
                job = Job.new(job_hash)
                expect(job.send(predicate_method)).to be_truthy
              end
            end

            context 'False' do
              it 'should response false' do
                job_hash = { response_field_name => 'False' }
                job = Job.new(job_hash)
                expect(job.send(predicate_method)).to be_falsey
              end
            end
          end

          context 'when not in response' do
            it 'returns false' do
              job_hash = {}
              job = Job.new(job_hash)
              expect(job.send(predicate_method)).to be_falsey
            end
          end
        end
      end
    end
  end
end
