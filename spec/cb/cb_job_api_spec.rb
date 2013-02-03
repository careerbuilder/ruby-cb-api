require 'spec_helper'

module Cb
  describe Cb::CbJobApi do
    context ".search" do
        it "should perform a blank search", :vcr => {:cassette_name => "search/blank"} do
            search = Cb::CbJobApi.search()

            search.count.should == 25
            search[0].is_a?(Cb::CbJob).should == true
            search[24].is_a?(Cb::CbJob).should == true

        end
    end
  end
end