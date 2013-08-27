require 'spec_helper'

module Cb
  describe Cb::JobApi do
    context '.search' do
      it 'should perform a blank search', :vcr => { :cassette_name => 'job/search/blank' } do
        search = Cb.job_search_criteria.location('Atlanta, GA').radius(10).search()

        search.cb_response.total_pages.should >= 1
        search.cb_response.total_count.should >= 1
        search.cb_response.first_item_index.should == 1
        search.cb_response.last_item_index.should >= 1
        search.api_error.should == false

        # # make sure we have results, and they're of the correct type
        search.count.should == 25
        search[0].is_a?(Cb::CbJob).should == true
        search[24].is_a?(Cb::CbJob).should == true

        # # make sure our jobs are properly populated
        job = search[Random.new.rand(0..24)]

        job.did.length.should >= 19
        job.title.length.should > 1
        job.company_name.length.nil?.should == false
        job.posted_date.length.should > 1

        company = job.find_company
        company.is_a?(Cb::CbCompany).should == true unless company.nil?
      end

      it 'should return zero results', :vcr => { :cassette_name => 'job/search/no_results' } do
        search = Cb.job_search_criteria.location('Someplace Sunny, CA').radius(5)
                                       .keywords('Retchko4Prez').page_number(99).search()
        search.cb_response.total_count.should == 0
        search.cb_response.errors.nil?.should == true
        search.api_error.should == false
      end

      it 'should set api error on a bogus request', :vcr => {:cassette_name => 'job/search/bogus_request'} do
        correct_url = Cb.configuration.uri_job_search

        Cb.configuration.uri_job_search = Cb.configuration.uri_job_search + 'a'
        search = Cb.job_search_criteria.location('Atlanta, GA').radius(10).search()
        Cb.configuration.uri_job_search = correct_url

        search.empty?.should be_true
        search.api_error.should == true
      end
    end

    context '.find_by_did'
      it 'should load a job in a blank search', :vcr => { :cassette_name => 'job/find' } do
        # run a job search, so we can load a job
        search = Cb.job.search()

        search.cb_response.total_pages.should >= 1
        search.cb_response.total_count.should >= 1
        search.cb_response.first_item_index.should == 1
        search.cb_response.last_item_index.should >= 1
        search.api_error.should == false

        job = Cb.job.find_by_did(search[Random.new.rand(0..24)].did)

        job.did.length.should >= 19
        job.title.length.should > 1
        job.company_name.length.nil?.should == false
        job.api_error.should == false
      end

      it 'should not load job for a bad did', :vcr => { :cassette_name => 'job/bad_did' } do
        job = Cb.job.find_by_did('bogus_did')

        job.cb_response.errors.is_a?(Array).should == true
        job.cb_response.errors.first.include?('Job was not found').should == true
        job.api_error.should == false
      end

      it 'should set api error for bogus request', :vcr => { :cassette_name => 'job/bogus_request' } do
        correct_url = Cb.configuration.uri_job_find

        Cb.configuration.uri_job_find = Cb.configuration.uri_job_find + 'a'
        job = Cb.job.find_by_did('bogus_did')
        Cb.configuration.uri_job_find = correct_url

        job.nil?.should be_true
        job.api_error.should == true
      end
    end
end