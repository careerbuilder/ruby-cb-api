require 'spec_helper'

describe Cb::Responses::Job::SearchV3 do
  
  shared_examples 'search_v3_response' do |example_response_file|

    let(:search_response_hash) { YAML.load open(example_response_file) }
    let(:search_results) { described_class.new(search_response_hash) }

    describe '#model' do
    
      it 'returns a JobResultsV3' do
        expect(search_results.model).to be_instance_of(Cb::Models::JobResultsV3) 
      end
    end
  
    describe '#response' do
    
      it 'returns a hash' do
        expect(search_results.response).to be_instance_of(Hash)
      end
    end
  end
  
  it_behaves_like "search_v3_response", 'spec/support/response_stubs/search_result_v3.yml'
  it_behaves_like "search_v3_response", 'spec/support/response_stubs/company_colapse_search_result_v3.yml'

end
