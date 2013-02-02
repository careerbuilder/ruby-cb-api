require 'spec_helper'

module Cb
  describe Cb::CbJob do
    context ".new" do
      it "should create an empty new job" do
        did = "Jesse4Prez"
        title = "Rails Guru Needed"
        description = "Someone who is proficient in all things ruby, rails, and open source needed immediately!"
        requirements = "Solid OO, web technologies, and a good sense of humor! Must be willing to work for peanuts and attaboys."
        begin_date = Date.today - 30
        end_date = Date.today + 1


        job = Cb::CbJob.new(:DID => did, :JobTitle => title, :JobDescription => description, 
                            :JobRequirements => requirements, :BeginDate => begin_date, 
                            :EndDate => end_date)

        job.did.should == did
        job.title.should == title
        job.description.should == description
        job.requirements.should == requirements
        job.begin_date.should == begin_date
        job.end_date.should == end_date
      end
    end
  end
end