require 'spec_helper'

module Cb
  describe Responses::Job::Report do
    let(:response) { described_class.new(json) }
    let(:json) do
      {
          'Errors' => [],
          'Success' => 'true'
      }
    end

    it { expect(response.model.first.class).to eq(Cb::Models::ReportJob) }
    it { expect(response.model.count).to eq(1) }
    it { expect(response.model.first.success).to eq(true) }
    it { expect(response.hash_containing_metadata).to eq(json) }
  end

  context 'invalid args' do
    let(:json) do
      {
          'Errors' => []
      }
    end

    let(:error) { ExpectedResponseFieldMissing }

    it { expect { Responses::Job::Report.new(json) }.to raise_error error }
  end
end
