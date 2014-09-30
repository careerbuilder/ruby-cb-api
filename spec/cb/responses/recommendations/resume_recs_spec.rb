require 'spec_helper'

describe Cb::Responses::Recommendations do
  let(:response) { JSON.parse(File.read('spec/support/response_stubs/recommendations_for_resume.json')) }
  let(:api_job_result_collection) { Cb::Responses::Recommendations.new(response) }

  it { expect(api_job_result_collection.models.first).to be_an_instance_of Cb::Models::RecommendedJob }

  describe '#root_node' do
    it { expect(api_job_result_collection.root_node).to eq('data')}
  end

  context 'when the Api response is missing the results field' do
    it 'raises an exception' do
      response.delete('data')
      expect{ Cb::Responses::Recommendations.new(response) }.
          to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
        expect(ex.message).to include 'data'
      end
    end
  end
end
