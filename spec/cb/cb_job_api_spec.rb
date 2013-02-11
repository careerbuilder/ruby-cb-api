require 'spec_helper'

module Cb
  describe Cb::CbJobApi do
    context ".search" do
        it "should perform a blank search", :vcr => { :cassette_name => "job/search/blank" } do
            job_api = Cb::CbJobApi.new()
            search = job_api.search()

            job_api.total_pages.should >= 1
            job_api.total_count.should >= 1
            job_api.first_item_index.should == 1
            job_api.last_item_index.should >= 1

            # make sure we have results, and they're of the correct type
            search.count.should == 25
            search[0].is_a?(Cb::CbJob).should == true
            search[24].is_a?(Cb::CbJob).should == true

            # make sure our jobs are properly populated
            job = search[rand(0..24)]
            job.did.length.should >= 19
            job.title.length.should > 1
            job.company_name.length.nil?.should == false
            job.posted_date.length.should > 1

            a = job.find_company
            puts a
        end
    end

    context ".find_by_did"
        it "should load a job in a blank search", :vcr => { :cassette_name => "job/find" } do
            # run a job search, so we can load a job
            job_api = Cb::CbJobApi.new()
            search = job_api.search()

            job_api.total_pages.should >= 1
            job_api.total_count.should >= 1
            job_api.first_item_index.should == 1
            job_api.last_item_index.should >= 1

            job = job_api.find_by_did(search[rand(0..24)].did)

            job.did.length.should >= 19
            job.title.length.should > 1
            job.company_name.length.nil?.should == false
        end
    end
end