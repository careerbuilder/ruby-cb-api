require 'spec_helper'

module Cb
  describe Responses::EmailSubscription::Response do
    let(:json_hash) do
      {
        "Errors" => [],
        "Status" => "Success",
        "SubscriptionValues" => {
            "CareerResources" => true,
            "ProductSponsorInfo" => false,
            "ApplicantSurveyInvites" => true,
            "JobRecs" => true,
            "DJR" => false,
            "ResumeViewed" => true,
            "ApplicationViewed" => false
          }
        }
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        expect(Responses::EmailSubscription::Response.new(json_hash).class).to eq Responses::EmailSubscription::Response
      end

      it 'instantiates new model objects' do
        model = Responses::EmailSubscription::Response.new(json_hash).model

        expect(model.class).to eq Cb::Models::EmailSubscription

        expect(model.career_resources).to eq 'true'
        expect(model.product_sponsor_info).to eq 'false'
        expect(model.applicant_survey_invites).to eq 'true'
        expect(model.job_recs).to eq 'true'
        expect(model.djr).to eq 'false'
        expect(model.resume_viewed).to eq 'true'
        expect(model.application_viewed).to eq 'false'
      end

    end
  end
end
