require 'json'

module Cb
  class EmailSubscriptionApi
    #############################################################
    ## Retrieve subscription values for a user
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/usersubscriptionretrieve.aspx
    #############################################################
    def self.retrieve_by_did(did, host_site = '')
      my_api = Cb::Utils::Api.new()
      json_hash = my_api.cb_get_secure(Cb.configuration.uri_subscription_retrieve, :query => {:ExternalID => did, :Hostsite => host_site})

      if json_hash.has_key?('SubscriptionValues') && json_hash['SubscriptionValues'].present?
        subscription = CbEmailSubscription.new(json_hash['SubscriptionValues'])
        my_api.append_api_responses(subscription, json_hash['SubscriptionValues'])
      end
      my_api.append_api_responses(subscription, json_hash)

      return subscription
    end


    #############################################################
    ## Update subscription values for a user
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/usersubscriptionretrieve.aspx
    #############################################################
    def self.modify_subscription ext_id, host_site, career_resources, product_sponsor_info, applicant_survey_invites, job_recs, unsubscribe_all
      if unsubscribe_all && unsubscribe_all != 'false'
        career_resources = product_sponsor_info = applicant_survey_invites = job_recs = false.to_s
      end

      career_resources = career_resources.nil? ? 'false' : career_resources
      product_sponsor_info = product_sponsor_info.nil? ? 'false' : product_sponsor_info
      applicant_survey_invites = applicant_survey_invites.nil? ? 'false' : applicant_survey_invites
      job_recs = job_recs.nil? ? 'false' : job_recs
      unsubscribe_all = unsubscribe_all.nil? ? 'false' : unsubscribe_all

      my_api = Cb::Utils::Api.new()

      xml_body = "<Request>"
      xml_body += "<DeveloperKey>" + Cb.configuration.dev_key.to_s + "</DeveloperKey>"
      xml_body += "<ExternalID>" + ext_id.to_s + "</ExternalID>"
      xml_body += "<Hostsite>" + host_site.to_s + "</Hostsite>"
      xml_body += "<CareerResources>" + career_resources.to_s + "</CareerResources>"
      xml_body += "<ProductSponsorInfo>" + product_sponsor_info.to_s + "</ProductSponsorInfo>"
      xml_body += "<ApplicantSurveyInvites>" + applicant_survey_invites.to_s + "</ApplicantSurveyInvites>"
      xml_body += "<JobRecs>" + job_recs.to_s + "</JobRecs>"
      xml_body += "<UnsubscribeAll>" + unsubscribe_all.to_s + "</UnsubscribeAll>"
      xml_body += "</Request>"


      json_hash = my_api.cb_post(Cb.configuration.uri_subscription_modify,
                                  :body => xml_body)

      if json_hash.has_key?('SubscriptionValues') && json_hash['SubscriptionValues'].present?
        subscription = CbEmailSubscription.new(json_hash['SubscriptionValues'])
        my_api.append_api_responses(subscription, json_hash['SubscriptionValues'])
      end
      my_api.append_api_responses(subscription, json_hash)
      return subscription
    end

  end
end