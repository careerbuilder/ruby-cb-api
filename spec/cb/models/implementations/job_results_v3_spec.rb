require 'spec_helper'

module Cb::Models
  describe JobResultsV3 do
    let(:search_response_hash) { YAML.load open('spec/support/response_stubs/search_result_v3.yml') }
    let(:search_results) { JobResultsV3.new(search_response_hash) }
    
    describe '#api_result' do
      
      it 'returns a Hash' do
        expect(search_results.api_response).to be_instance_of(Hash) 
      end
    end
  end
end
