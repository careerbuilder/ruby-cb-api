require 'spec_helper'

module Cb
  describe Models::ReportJob do

    shared_examples_for 'report job' do
      let(:model) { Cb::Models::ReportJob.new(success: status) }

      it { expect(model.success).to eql(status) }
    end

    context 'status is true' do
      let(:status) { true }
      it_behaves_like 'report job'
    end

    context 'status is false' do
      let(:status) { false }
      it_behaves_like 'report job'
    end
  end
end
