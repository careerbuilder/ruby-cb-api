require 'spec_helper'

module Cb
  describe Cb::EmailSubscriptionApi do
    context '.retrieve_by_did' do
      it 'retrieve a users email subscription and update it' do
        did = 'XRHS6FP78P5H30WLMB4G'
        subscription = Cb.email_subscription.retrieve_by_did(did)

        test_subscription = Cb.email_subscription.modify_subscription(
            did,
            subscription.career_resources,
            subscription.product_sponsor_info,
            subscription.applicant_survey_invites,
            subscription.job_recs,
            false
        )

        test_subscription.career_resources.should == subscription.career_resources
        test_subscription.product_sponsor_info.should == subscription.product_sponsor_info
        test_subscription.applicant_survey_invites.should == subscription.applicant_survey_invites
        test_subscription.job_recs.should == subscription.job_recs


      end
    end
  end
end