require 'spec_helper'

module Cb
  describe Cb::RecommendationApi do
    context '.for_job' do
      it 'should get recommendations for a job', :vcr => { :cassette_name => 'job/recommendation/for_job' } do
        search = Cb.job_search_criteria.location('Atlanta, GA').radius(10).search()
        job = search[Random.new.rand(0..24)]
        recs = Cb.recommendation.for_job job.did

        recs.cb_response.errors.nil?.should == true
        recs.count.should > 0
        recs.api_error.should == false

        recs[0].is_a?(Cb::CbJob).should == true
        recs[0].city.blank?.should == false
        recs[0].state.blank?.should == false
      end

      it 'should get no recommendations for bogus job', :vcr => { :cassette_name => 'job/recommendation/for_job_bad_job' } do
        recs = Cb.recommendation.for_job 'bogus_did'

        recs.cb_response.errors.nil?.should == true
        recs.count.should == 0
        recs.api_error.should == false
      end
    end

    context '.for_user' do
      it 'should get recommendations for a user', :vcr => { :cassette_name => 'job/recommendation/for_user' } do
        # external_id for captainmorgaintest@careerbuilder.com
        test_user_external_id = 'XRHS30G60RWSQ5P1S8RG'
        recs = Cb.recommendation.for_user test_user_external_id

        recs.cb_response.errors.nil?.should == true
        recs.count.should > 0
        recs[0].is_a?(Cb::CbJob).should == true
        recs.api_error.should == false
      end

      it 'should get no recommendations for bogus job', :vcr => { :cassette_name => 'job/recommendation/for_job_bad_user' } do
        recs = Cb.recommendation.for_user 'bogus_user'

        recs.cb_response.errors.nil?.should == false
        recs.count.should == 0
        recs.api_error.should == false
      end
    end

    context '.for_company' do
      # There are no legit tests for this method!
    end
  end
end