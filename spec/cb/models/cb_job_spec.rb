require 'spec_helper'

module Cb
  describe CbJob do
    describe '#initialize' do

      context 'With valid response data' do
        let(:job_response) {{
          'ApplyRequirements' => {
            'ApplyRequirement' => 'noonlineapply'
          }, 'CustomApplyType' => 'CASKIPRESUME'
        }}
        let(:job) { Cb::CbJob.new job_response }

        it 'should set apply_requirements' do
          job.apply_requirements.should == ['noonlineapply']
        end

        # REFACTOR - improper spec scope
        it 'should pass appy requirements to the ResponseArrayExtractor' do
          Cb::Utils::ResponseArrayExtractor.should_receive(:extract).with(job_response, 'ApplyRequirements')
          Cb::CbJob.new job_response
        end

        it 'should set custom_apply_type' do
          job.custom_apply_type.should == 'CASKIPRESUME'
        end

        describe '#skip_resume?' do
          it 'should evaluate as true' do
            expect(job.skip_resume?).to be_true
          end
        end
      end
      
    end
  end
end