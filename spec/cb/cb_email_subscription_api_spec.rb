require 'spec_helper'

module Cb
  describe Cb::EmailSubscriptionApi do
    context '.retrieve_by_did' do
      it 'retrieve a users email subscription and update it' do
        did = 'XRHS6FP78P5H30WLMB4G'
        subscription = Cb.email_subscription.retrieve_by_did(did, 'WR')

        subscription.nil?.should be_false
        subscription.cb_response.errors.empty?.should be_true
        subscription.cb_response.status.should == 'Success'
        subscription.api_error.should == false

        test_subscription = Cb.email_subscription.modify_subscription(
            did,
            'WR',
            subscription.career_resources,
            subscription.product_sponsor_info,
            subscription.applicant_survey_invites,
            subscription.job_recs,
            false
        )

        test_subscription.nil?.should be_false
        test_subscription.career_resources.should == subscription.career_resources.to_s
        test_subscription.product_sponsor_info.should == subscription.product_sponsor_info.to_s
        test_subscription.applicant_survey_invites.should == subscription.applicant_survey_invites.to_s
        test_subscription.job_recs.should == subscription.job_recs.to_s

        test_subscription.cb_response.errors.empty?.should be_true
        test_subscription.cb_response.status.should == 'Success'
        test_subscription.api_error.should == false

      end

      it 'retrieve a users email subscription and unsubscribe to all' do
        did = 'XRHS6FP78P5H30WLMB4G'
        subscription = Cb.email_subscription.retrieve_by_did(did, 'WR')

        subscription.nil?.should be_false
        subscription.cb_response.errors.empty?.should be_true
        subscription.cb_response.status.should == 'Success'
        subscription.api_error.should == false

        test_subscription = Cb.email_subscription.modify_subscription(
            did,
            'WR',
            subscription.career_resources,
            subscription.product_sponsor_info,
            subscription.applicant_survey_invites,
            subscription.job_recs,
            true
        )

        test_subscription.nil?.should be_false
        test_subscription.cb_response.errors.empty?.should be_true
        test_subscription.cb_response.status.should == 'Success'
        test_subscription.api_error.should == false

        test_subscription.career_resources.should == 'false'
        test_subscription.product_sponsor_info.should == 'false'
        test_subscription.applicant_survey_invites.should == 'false'
        test_subscription.job_recs.should == 'false'


      end
      it 'retrieve a users email subscription and update it' do
        did = 'XRHS6FP78P5H30WLMB4G'
        subscription = Cb.email_subscription.retrieve_by_did(did, 'WR')

        subscription.nil?.should be_false
        subscription.cb_response.errors.empty?.should be_true
        subscription.cb_response.status.should == 'Success'
        subscription.api_error.should == false

        subscription.applicant_survey_invites = true
        subscription.career_resources = true

        test_subscription = Cb.email_subscription.modify_subscription(
            did,
            'WR',
            subscription.career_resources,
            subscription.product_sponsor_info,
            subscription.applicant_survey_invites,
            subscription.job_recs,
            'false'
        )

        test_subscription.nil?.should be_false
        test_subscription.cb_response.errors.empty?.should be_true
        test_subscription.cb_response.status.should == 'Success'
        test_subscription.api_error.should == false

        test_subscription.career_resources.should == subscription.career_resources.to_s
        test_subscription.product_sponsor_info.should == subscription.product_sponsor_info.to_s
        test_subscription.applicant_survey_invites.should == subscription.applicant_survey_invites.to_s
        test_subscription.job_recs.should == subscription.job_recs.to_s
      end

      it 'should set errors and return nil if bogus did' do
        did = 'bogus'
        subscription = Cb.email_subscription.retrieve_by_did(did, 'WR')

        subscription.nil?.should be_true
        subscription.cb_response.errors.empty?.should be_false
        subscription.api_error.should == false

      end

      it 'should set errors with empty did' do
        did = ''
        subscription = Cb.email_subscription.retrieve_by_did(did, 'WR')

        subscription.nil?.should be_true
        subscription.cb_response.errors.empty?.should be_false
        subscription.api_error.should == false

      end
    end

  end
end