require 'spec_helper'

describe Cb::Requests::JobSearch::Get do
  let(:argument_hash) { {some_arg: 'some arg'} }
  let(:token) { 'fake oauth token' }
  let(:headers) { {'HostSite' => 'US', 'Accept' => 'application/json;version=3.0', 'fake_header' => 'fake'} }
  let(:job_search) { Cb::Requests::JobSearch::Get.new(argument_hash, token) }
    
  context '#http_method' do
    it { expect(job_search.http_method).to be(:get) }
  end
  
  context '#query' do
    it { expect(job_search.query).to eq(argument_hash) }
  end
  
  context '#endpoint_uri' do
    it { expect(job_search.endpoint_uri).to eq('/consumer/jobs/search/') }
  end
  
  context '#headers' do
    it do
      allow(token).to receive(:headers).and_return( {'fake_header' => 'fake'} )
      expect(job_search.headers).to eq(headers)
    end
  end

end
