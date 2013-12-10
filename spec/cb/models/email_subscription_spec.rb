require 'spec_helper'

module Cb::Models
  describe EmailSubscription do
    context '.new' do
      it 'should create an empty new email subscription' do
        career_resources = 'true'
        product_sponsor_info = 'true'
        applicant_survey_invites = 'false'
        job_recs = 'true'


        subscription = EmailSubscription.new('CareerResources' => career_resources,
                              'ProductSponsorInfo' => product_sponsor_info,
                              'ApplicantSurveyInvites' => applicant_survey_invites,
                              'JobRecs' => job_recs)




        subscription.career_resources.should == career_resources
        subscription.product_sponsor_info.should == product_sponsor_info
        subscription.applicant_survey_invites.should == applicant_survey_invites
        subscription.job_recs.should == job_recs

      end
    end
  end
end