require 'spec_helper'

module Cb::Models
  describe Job do
    describe '#initialize' do

      context 'When ApplyRequirements hash is contained in the hash passed into the constructor' do
        let(:job_hash) do
          { 'ApplyRequirements' => { 'ApplyRequirement' => 'noonlineapply' }}
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
        { :api_field => 'HasQuestionnaire',    :predicate_method => :has_questionnaire? },
        { :api_field => 'CanBeQuickApplied',   :predicate_method => :can_be_quick_applied? },
        { :api_field => 'ManagesOthers',       :predicate_method => :manages_others? },
        { :api_field => 'IsScreenerApply',     :predicate_method => :screener_apply? },
        { :api_field => 'IsSharedJob',         :predicate_method => :shared_job? },
        { :api_field => 'RelocationCovered',   :predicate_method => :relocation_covered? },
        { :api_field => 'ExternalApplication', :predicate_method => :external_application? },
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
              job_hash = Hash.new
              job = Job.new(job_hash)
              expect(job.send(predicate_method)).to be_falsey
            end
          end
        end
      end

    end
  end
end
