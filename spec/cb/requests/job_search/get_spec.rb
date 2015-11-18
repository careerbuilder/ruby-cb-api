require 'spec_helper'

describe Cb::Requests::JobSearch::Get do
  let(:argument_hash) { {some_arg: 'some arg'} }
  let(:token) { 'fake oauth token' }
  let(:job_search) { Cb::Requests::JobSearch::Get.new(argument_hash, token) }
    
  context '#http_method' do
    it { expect(job_search.http_method).to equal(:get) }
  end
  
  context '#query' do
    it { expect(job_search.query).to equal(argument_hash) }
  end
  
  context '#endpoint_uri' do
    it { expect(job_search.endpoint_uri).to eq('/consumer/jobs/search/') }
  end

end
