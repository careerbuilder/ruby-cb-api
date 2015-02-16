require 'spec_helper'

module Cb::Models
  describe RecommendedJob do
    describe '#new' do
      context 'When ApplyRequirements hash is containd in the hash passed into the constructor' do
        let(:job_hash) do
          { 'ApplyRequirements' => { 'ApplyRequirement' => 'noonlineapply' }}
        end

        it 'then the apply_requirements field should be set' do
          job = Job.new job_hash
          expect(job.apply_requirements).to eq(['noonlineapply'])
        end
      end
    end


  end
end
