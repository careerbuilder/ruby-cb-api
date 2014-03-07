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
          job.apply_requirements.should == ['noonlineapply']
        end

        it 'and the ResponseArrayExtractor should have received the message, #extract' do
          Cb::Utils::ResponseArrayExtractor.should_receive(:extract).with(job_hash, 'ApplyRequirements')
          Job.new job_hash
        end
      end

      # if another 'boolean' field is added to the model with a matching predicate to go with, add it
      # to the set of mappings below and it will test itself for you!
      context 'predicates:' do
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
          context mapping[:api_field] do
            context 'when in response and set to (string) ' do
              context 'True' do
                it 'should respond true' do
                  job_hash = { mapping[:api_field] => 'True' }
                  expect(Job.new(job_hash).send(mapping[:predicate_method])).to be_true
                end
              end

              context 'False' do
                it 'should response false' do
                  job_hash = { mapping[:api_field] => 'False' }
                  expect(Job.new(job_hash).send(mapping[:predicate_method])).to be_false
                end
              end
            end
          end
        end

      end
    end
  end
end