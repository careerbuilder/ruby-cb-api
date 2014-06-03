require_relative '../base'

module Cb
  module Requests
    module EmailSubscription
      class Modify < Base

        def endpoint_uri
          Cb.configuration.uri_subscription_modify
        end

        def http_method
          :post
        end

        def body
          <<eos
<Request>
<DeveloperKey>#{Cb.configuration.dev_key.to_s}</DeveloperKey>
<ExternalID>#{@args[:external_id]}</ExternalID>
<Hostsite>#{@args[:host_site]}</Hostsite>
<CareerResources>#{validate @args[:career_resources]}</CareerResources>
<ProductSponsorInfo>#{validate @args[:product_sponsor_info]}</ProductSponsorInfo>
<ApplicantSurveyInvites>#{validate @args[:applicant_survey_invites]}</ApplicantSurveyInvites>
<JobRecs>#{validate @args[:job_recs]}</JobRecs>
<DJR>#{validate @args[:djr]}</DJR>
<UnsubscribeAll>#{@args[:unsubscribe_all]}</UnsubscribeAll>
</Request>
eos
        end

        private

        def validate value
          return value unless unsubscribe_all?
          false.to_s
        end

        def unsubscribe_all?
          @args[:unsubscribe_all] == "true" || @args[:unsubscribe_all] == true
        end

      end
    end
  end
end
