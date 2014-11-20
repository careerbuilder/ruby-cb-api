require 'spec_helper'

module Cb
  describe Responses::HireInsider::Get do
    let(:response) { JSON.parse(File.read('spec/support/response_stubs/job_report.json')) }
    let(:job_report) { Cb::Responses::HireInsider::Get.new(response) }

    context 'when everything works as expected' do
      it { expect(job_report.models).to be_a(Cb::Models::JobReport) }
    end
  end
end