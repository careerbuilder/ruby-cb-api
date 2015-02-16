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




        expect(subscription.career_resources).to eq(career_resources)
        expect(subscription.product_sponsor_info).to eq(product_sponsor_info)
        expect(subscription.applicant_survey_invites).to eq(applicant_survey_invites)
        expect(subscription.job_recs).to eq(job_recs)

      end
    end
  end
end