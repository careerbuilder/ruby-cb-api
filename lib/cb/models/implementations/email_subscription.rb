module Cb
  module Models
    class EmailSubscription
      attr_accessor :career_resources, :product_sponsor_info, :applicant_survey_invites,
                    :job_recs, :unsubscribe_all, :djr, :resume_viewed, :application_viewed

      def initialize(args = {})
        return if args.nil?

        @career_resources             = args['CareerResources'].to_s || ''
        @product_sponsor_info         = args['ProductSponsorInfo'].to_s || ''
        @applicant_survey_invites     = args['ApplicantSurveyInvites'].to_s || ''
        @job_recs                     = args['JobRecs'].to_s || ''
        @djr                          = args['DJR'].to_s || ''
        @resume_viewed                = args['ResumeViewed'].to_s || ''
        @application_viewed           = args['ApplicationViewed'].to_s || ''
      end
    end
  end
end
