require 'json'

module Cb
  class EmailSubscriptionApi
    #############################################################
    ## Retrieve subscription values for a user
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/usersubscriptionretrieve.aspx
    #############################################################
    def self.retrieve_by_did(did)
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_get(Cb.configuration.uri_subscription_retrieve, :query => {:ExternalID => did})
      json_hash = JSON.parse(cb_response.response.body)
      subscription = CbEmailSubscription.new(json_hash['SubscriptionValues'])

      return subscription
    end


    #############################################################
    ## Update subscription values for a user
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/usersubscriptionretrieve.aspx
    #############################################################
    def self.modify_subscription ext_id, career_resources, product_sponsor_info, applicant_survey_invites, job_recs, unsubscribe_all
      if unsubscribe_all
        career_resources = product_sponsor_info = applicant_survey_invites = job_recs = false.to_s
      end

      my_api = Cb::Utils::Api.new()

      xml_body = "<Request>"
      xml_body += "<DeveloperKey>" + Cb.configuration.dev_key.to_s + "</DeveloperKey>"
      xml_body += "<ExternalID>" + ext_id.to_s + "</ExternalID>"
      xml_body += "<CareerResources>" + career_resources.to_s + "</CareerResources>"
      xml_body += "<ProductSponsorInfo>" + product_sponsor_info.to_s + "</ProductSponsorInfo>"
      xml_body += "<ApplicantSurveyInvites>" + applicant_survey_invites.to_s + "</ApplicantSurveyInvites>"
      xml_body += "<JobRecs>" + job_recs.to_s + "</JobRecs>"
      xml_body += "<UnsubscribeAll>" + unsubscribe_all.to_s + "</UnsubscribeAll>"
      xml_body += "</Request>"


      cb_response = my_api.cb_post(Cb.configuration.uri_subscription_modify,
                                  :body => xml_body)

      json_hash = JSON.parse(cb_response.response.body)

      subscription = CbEmailSubscription.new(json_hash['SubscriptionValues'])

      return subscription
    end

  end
end