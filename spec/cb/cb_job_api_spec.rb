require 'spec_helper'

module Cb
  describe Cb::JobApi do
    context '.search' do
      context 'when the search returns with results' do
        before(:each) do
          content = { ResponseJobSearch: {
            SearchMetaData: { SearchLocations: { SearchLocation: ['tahiti'] } },
            Results: { JobSearchResult: [Hash.new] } } }

          stub_request(:get, uri_stem(Cb.configuration.uri_job_search)).
            to_return(:body => content.to_json)
        end

        it 'returns an array of job models' do
          search = Cb.job_search_criteria.search()
          search.api_error.should == false
          search[0].is_a?(Cb::CbJob).should == true
        end
      end
    end

    context '.find_by_criteria' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_job_find)).
          to_return(:body => { ResponseJob: { Job: Hash.new } }.to_json)
      end

      let(:criteria) { Cb::JobDetailsCriteria.new }

      context 'when a criteria object is the input param' do
        it 'returns a single job model' do
          model = Cb::JobApi.find_by_criteria(criteria)
          expect(model).to be_an_instance_of Cb::CbJob
        end
      end
    end

    context '.find_by_did' do
      context 'when a string job did is input' do
        let(:criteria) { double(Cb::JobDetailsCriteria) }

        before(:each) { Cb::JobDetailsCriteria.stub(:new).and_return(criteria) }

        it 'constructs a criteria object, sets the input did, and calls #find_by_criteria' do
          did = 'fake-did'

          Cb::JobApi.should_receive(:find_by_criteria).with(criteria)
          criteria.should_receive(:did=).with(did)

          Cb::JobApi.find_by_did(did)
        end
      end
    end
  end
end
