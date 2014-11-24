require 'spec_helper'

module Cb
  describe Responses::JobReport::Get do
    let(:response) { JSON.parse(File.read('spec/support/response_stubs/job_report.json')) }
    let(:job_report) { Cb::Responses::JobReport::Get.new(response) }

    context 'when everything works as expected' do
      it { expect(job_report.models).to be_a(Cb::Models::JobReport) }
    end

    context 'when response hash cannot be validated due to' do
      context 'missing root node' do
        let(:response) do { 'herp' => 'derp' } end

        it 'raises an error' do
          expect{ Responses::JobReport::Get.new(response) }.
            to raise_error(ExpectedResponseFieldMissing) do |ex|
              expect(ex.message).to include 'Results'
            end
        end
      end
    end
  end
end