require 'spec_helper'

module Cb
  describe Cb::CbJobApi do
    context ".search" do
        it "should perform a blank search", :vcr => { :cassette_name => "job/search/blank" } do
            search = Cb::CbJobApi.search()

            # make sure we have results, and they're of the correct type
            search.count.should == 25
            search[0].is_a?(Cb::CbJob).should == true
            search[24].is_a?(Cb::CbJob).should == true

            # make sure our jobs are properly populated
            job = search[rand(0..24)]
            job.did.length.should >= 19
            job.title.length.should > 1
            job.company.length.nil?.should == false
            job.posted_date.length.should > 1
        end
    end

    context ".find_by_did"
        it "should load a job in a blank search", :vcr => { :cassette_name => "job/find" } do
            # run a job search, so we can load a job
            search = Cb::CbJobApi.search()

            job = Cb::CbJobApi.find_by_did(search[rand(0..24)].did)

            puts job

        end
    end
end