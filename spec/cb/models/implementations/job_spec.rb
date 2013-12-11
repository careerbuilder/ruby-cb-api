require 'spec_helper'

module Cb::Models
  describe Job do
    describe '#initialize' do

      context 'When ApplyRequirements hash is contained in the hash passed into the constructor' do
        let(:job_hash) {{
          'ApplyRequirements' => {
            'ApplyRequirement' => 'noonlineapply'
          }
        }}
        it 'then the apply_requirements field should be set' do
          job = Job.new job_hash
          job.apply_requirements.should == ['noonlineapply']
        end
        it 'and the ResponseArrayExtractor should have received the message, #extract' do
          Cb::Utils::ResponseArrayExtractor.should_receive(:extract).with(job_hash, 'ApplyRequirements')
          Job.new job_hash
        end
      end
      
    end
  end
end