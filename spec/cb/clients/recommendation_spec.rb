require 'spec_helper'
require 'support/mocks/oauth_token'

module Cb
  describe Cb::Clients::Recommendation do
    let(:api_job_result_collection) { [Hash.new] }

    shared_context :for_job do
      it 'should get recommendations for a job using a hash' do
        recs = Cb.recommendation.for_job({ :JobDID => 'fake-did' })

        recs[0].is_a?(Cb::Models::Job).should == true
        recs.count.should > 0
        recs.api_error.should == false
      end

      it 'should get recommendations for a job using the old way' do
        recs = Cb.recommendation.for_job('fake-did')

        recs[0].is_a?(Cb::Models::Job).should == true
        recs.count.should > 0
        recs.api_error.should == false
      end
    end

    context '.for_job' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_recommendation_for_job)).
          to_return(:body => { ResponseRecommendJob: { Request: Hash.new, RecommendJobResults: { RecommendJobResult: api_job_result_collection } } }.to_json)
      end

      include_context :for_job

      context 'when the api returns one job' do
        let(:api_job_result_collection) { Hash.new }
        
        include_context :for_job
      end
    end

    shared_context :for_user do
      it 'should get recommendations for a user using a hash' do
        test_user_external_id = 'XRHS30G60RWSQ5P1S8RG'
        recs = Cb.recommendation.for_user({ :ExternalID => test_user_external_id })

        recs.count.should > 0
        recs[0].is_a?(Cb::Models::Job).should == true
        recs.api_error.should == false
      end

      it 'should get recommendations for a user using the old way' do
        test_user_external_id = 'XRHS30G60RWSQ5P1S8RG'
        recs = Cb.recommendation.for_user(test_user_external_id)

        recs.count.should > 0
        recs[0].is_a?(Cb::Models::Job).should == true
        recs.api_error.should == false
      end
    end

    context '.for_user' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_recommendation_for_user)).
          to_return(:body => { ResponseRecommendUser: { Request: Hash.new, RecommendJobResults: { RecommendJobResult: api_job_result_collection } } }.to_json)
      end

      include_context :for_user

      context 'when the api returns one job' do
        let(:api_job_result_collection) { Hash.new }
        
        include_context :for_user
      end
    end

    context '.for_resume' do
      let(:content) {JSON.parse(File.read('spec/support/response_stubs/recommendations_for_resume.json'))}
      let(:token) {Mocks::OAuthToken.new(content)}
      let(:rec_call) {Cb.recommendation.for_resume(token, Hash.new)}
      let(:resume_hash) {Hash.new}
      let(:url) {Cb.configuration.uri_recommendation_for_resume}
      before do

      end
      it{ expect(rec_call).to be_a Array}
      it{ expect(rec_call.length).to eq(2)}
      it{ expect(rec_call[0]).to be_a Cb::Models::RecommendedJob}
    end
  end
end
