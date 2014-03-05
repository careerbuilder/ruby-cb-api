require 'spec_helper'

module Cb
  describe Cb::Clients::Job do
    describe '#search' do
      context 'when the search returns with results' do
        before(:each) do
          content = { ResponseJobSearch: {
              SearchMetaData: { SearchLocations: { SearchLocation: ['tahiti'] } },
              Results: { JobSearchResult: [Hash.new] } } }

          stub_request(:get, uri_stem(Cb.configuration.uri_job_search)).
              to_return(body: content.to_json)
        end

        it 'returns an array of job models' do
          response = Cb.job.search(Hash.new)
          response.model.jobs[0].is_a?(Cb::Models::Job).should == true
        end
      end

      context 'When the search returns only one result' do
        before(:each) do
          content = {
              ResponseJobSearch: {
                  SearchMetaData: { SearchLocations: { SearchLocation: ['tahiti'] } },
                  Results: { JobSearchResult: {} }
              }
          }
          stub_request(:get, uri_stem(Cb.configuration.uri_job_search)).to_return(:body => content.to_json)
        end

        it 'returns an array of job models' do
          search = Cb.job.search(Hash.new)
          search.model.jobs[0].is_a?(Cb::Models::Job).should == true
        end
      end

    end

  end
end
