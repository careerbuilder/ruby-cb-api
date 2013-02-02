require 'spec_helper'

module Cb
  describe Cb::CbJob do
    context ".new" do
      it "should create an empty new job" do
        job = Cb::CbJob.new(:did => "abc")

        job.did.should == ""

        puts Cb.methods(false)
      end
    end
  end
end