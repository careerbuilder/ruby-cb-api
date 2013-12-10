require 'spec_helper'

module Cb
  describe Cb::Clients::Recommendation do
    context '.for_job' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_recommendation_for_job)).
          to_return(:body => { ResponseRecommendJob: { Request: Hash.new, RecommendJobResults: { RecommendJobResult: [Hash.new] } } }.to_json)
      end

      it 'should get recommendations for a job' do
        recs = Cb.recommendation.for_job 'fake-did'

        recs[0].is_a?(Cb::CbJob).should == true
        recs.count.should > 0
        recs.api_error.should == false
      end
    end

    context '.for_user' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_recommendation_for_user)).
          to_return(:body => { ResponseRecommendUser: { Request: Hash.new, RecommendJobResults: { RecommendJobResult: [Hash.new] } } }.to_json)
      end

      it 'should get recommendations for a user' do
        test_user_external_id = 'XRHS30G60RWSQ5P1S8RG'
        recs = Cb.recommendation.for_user test_user_external_id

        recs.count.should > 0
        recs[0].is_a?(Cb::CbJob).should == true
        recs.api_error.should == false
      end
    end

    context '.for_company' do
      # There are no legit tests for this method!
      # lol! :(
    end
  end
end
