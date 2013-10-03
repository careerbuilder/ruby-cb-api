require 'spec_helper'

module Cb
  describe CbJob do
    context 'When ApplyRequirements hash is contained in the hash passed into the constructor' do
      let(:job_hash) {{
        'ApplyRequirements' => {
          'ApplyRequirement' => 'noonlineapply'
        }
      }}
      it 'then the apply_requirements field should be set' do
        job = Cb::CbJob.new job_hash
        job.apply_requirements.should == ['noonlineapply']
      end
      it 'and the ResponseArrayExtractor should have received the message, #extract' do
        Cb::Utils::ResponseArrayExtractor.should_receive(:extract).with(job_hash, 'ApplyRequirements')
        Cb::CbJob.new job_hash
      end
    end
  end
end