require 'json'

module Cb
  class ResumeApi
    #############################################################
    ## Retrieve resumes a user owns.
    ##
    ## Returns an array of resumes with external id and
    ## title set.
    ##
    ## Note: This does not load the resume, a subsequent resume
    ## retrieve is required.
    ##
    ## For detailed information around this API please visit:
    ## http://www.careerbuilder.com/api/ResumeInfo.aspx
    #############################################################
    def self.own_all(external_user_id, ignore_host_site = false)
      my_api = Cb::Utils::Api.new
      params = {"ExternalUserID" => external_user_id}
      if ignore_host_site
        params['IgnoreHostSite'] = 'true'
      end
      json_hash = my_api.cb_get(Cb.configuration.uri_resume_own_all, :query => params)

      resumes = []

      if json_hash.has_key?('ResponseOwnResumes') && json_hash['ResponseOwnResumes'].has_key?('Resumes')
        json_hash['ResponseOwnResumes']['Resumes']['Resume'].each do |resume_hash|
          resume = Cb::CbResume.new resume_hash
          resume.external_resume_id = resume_hash['ExternalID']
          resume.external_user_id = external_user_id
          resumes << resume
        end
      end

      return resumes
    end

    #############################################################
    ## Retrieve the contents of a resume by external id.
    ##
    ## For detailed information around this API please visit:
    ## http://www.careerbuilder.com/api/ResumeInfo.aspx
    #############################################################
    def self.retrieve_by_id resume_external_id, external_user_id
      my_api = Cb::Utils::Api.new
      params = {"ExternalID" => external_id, "ExternalUserID" => external_user_id}
      json_hash = my_api.cb_get(Cb.configuration.uri_resume_retrieve, :query => params)

      if json_hash.has_key?('ResponseRetrieve') && json_hash['ResponseRetrieve'].has_key?('Resume')
        resume = Cb::CbResume.new json_hash['ResponseRetrieve']['Resume']
        my_api.append_api_responses resume, json_hash['ResponseRetrieve']
      end

      return resume
    end

    #############################################################
    ## Retrieve the contents of a resume.
    ##
    ## For detailed information around this API please visit:
    ## http://www.careerbuilder.com/api/ResumeInfo.aspx
    #############################################################
    def self.retrieve resume
      my_api = Cb::Utils::Api.new
      params = {"ExternalID" => resume.external_resume_id, "ExternalUserID" => resume.external_user_id}
      json_hash = my_api.cb_get(Cb.configuration.uri_resume_retrieve, :query => params)

      if json_hash.has_key?('ResponseRetrieve') && json_hash['ResponseRetrieve'].has_key?('Resume')
        resume = resume.set_attributes json_hash['ResponseRetrieve']['Resume']
        my_api.append_api_responses resume, json_hash['ResponseRetrieve']
      end

      return resume
    end

    #############################################################
    ## TODO: Create a resume
    ##
    ## For detailed information around this API please visit:
    ## http://www.careerbuilder.com/api/ResumeInfo.aspx
    #############################################################
    def self.create resume
      my_api = Cb::Utils::Api.new
      json_hash = my_api.cb_post(Cb.configuration.uri_resume_create, :body => make_create_xml(resume))
    end

    #############################################################
    ## TODO: Update a resume
    ##
    ## For detailed information around this API please visit:
    ## http://www.careerbuilder.com/api/ResumeInfo.aspx
    #############################################################
    def self.update resume
      my_api = Cb::Utils::Api.new
      json_hash = my_api.cb_post(Cb.configuration.uri_resume_update, :body => make_update_xml(resume))
    end

    #############################################################
    ## TODO: Delete a resume
    ##
    ## For detailed information around this API please visit:
    ## http://www.careerbuilder.com/api/ResumeInfo.aspx
    #############################################################
    def self.delete resume
      my_api = Cb::Utils::Api.new
      json_hash = my_api.cb_post(Cb.configuration.uri_resume_delete, :body => make_delete_xml(resume))
    end

    private
    def make_create_xml(resume)
      xml = "<Request>"
      xml += "<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>"
      xml += "<ExternalID>#{resume.resume_external_id}</ExternalID>"
      xml += "<Test>false</Test>"
      xml += "<ExternalUserID>#{resume.user_external_id}</ExternalUserID>"
      cd = self.new_record? ? Date.current : self.created_at
      md = self.new_record? ? Date.current : self.updated_at
      xml += "<CreatedDT>#{cd.xmlschema}</CreatedDT>"
      xml += "<ModifiedDT>#{md.xmlschema}</ModifiedDT>"
      xml += "<Certifications>#{resume.certifications * ','}</Certifications>"
      xml += "<ShowContactInfo>#{resume.show_contact_info}</ShowContactInfo>"
      xml += "<Title>#{resume.title.xmlsafe}</Title>"
      xml += "<ResumeText>#{resume.resume_text.xmlsafe}</ResumeText>"
      xml += "<Visibility>#{resume.visibility.to_s.downcase}</Visibility>"
      xml += "<CanRelocateNationally>#{resume.can_relocate_nationally.to_s.downcase}</CanRelocateNationally>"
      xml += "<CanRelocateInternationally>#{resume.can_relocate_internationally.to_s.downcase}</CanRelocateInternationally>"
      xml += "<TotalYearsExperience>#{resume.total_years_experience.to_i}</TotalYearsExperience>"
      xml += "<HostSite>#{Cb.configuration.host_site}</HostSite>"
      xml += "<DesiredJobTypes>#{resume.desired_job_type}</DesiredJobTypes>" unless resume.desired_job_type.blank?
      xml += "<DesiredJobTypes>ETFE</DesiredJobTypes>" if resume.desired_job_type.blank?
      xml += "<RecentPayAmount>#{resume.recent_pay_amount.money_to_string}</RecentPayAmount>" unless resume.recent_pay_amount.blank?
      xml += "<RecentPayType>#{resume.recent_pay_type.downcase}</RecentPayType>" unless resume.recent_pay_type.blank?

      xml += "<CompanyExperiences>"
      resumes.company_experiences.each do |experience|
        xml += "<CompanyExperience>"
        xml += "<CompanyName>#{experience.company_name.xmlsafe}</CompanyName>"
        xml += "<JobTitle>#{experience.job_title.xmlsafe}</JobTitle>"
        xml += "<StartDate>#{experience.start_date.to_s}</StartDate>" unless experience.start_date.blank?
        xml += "<EndDate>#{experience.end_date.to_s}</EndDate>" unless experience.end_date.blank?
        xml += "<EndDate>1970-01-01</EndDate>" if experience.end_date.blank?
        xml += "<Details>#{experience.details.xmlsafe}</Details>"
        xml += "</CompanyExperience>"
      end
      xml += "</CompanyExperiences>"
      xml += "<Educations>"
      resume.educations.each do |education|
        xml += "<Education>"
        xml += "<SchoolName>#{education.school_name.xmlsafe}</SchoolName>"
        xml += "<Major>#{education.major.xmlsafe}</Major>"
        xml += "<DegreeCode>#{education.degree_code}</DegreeCode>"
        xml += "<GraduationDate>#{education.graduation_date.to_s}</GraduationDate>" unless education.graduation_date.blank?
        #Never actually needed:
        #xml += "<GPA>#{education.gpa.to_i}</GPA>"
        xml += "</Education>"
      end
      xml += "</Educations>"
      xml += "<Languages>"
      resume.languages.each do |language|
        xml += "<Language>#{language}</Language>"
      end
      xml += "</Languages>"
      xml += "</Request>"
      xml
    end

    def make_update_xml(resume)
      make_create_xml resume
    end

    def make_delete_xml(resume)
      raise "external_resume_id is undefined in CbResume." if resume.external_resume_id.blank?
      raise "external_user_id is undefined in CbResume." if resume.external_user_id.blank?

      xml = '<Request>'
      xml += "<DeveloperKey></DeveloperKey>"
      xml += "<ExternalID>#{resume.external_resume_id}</ExternalID>"
      xml += "<Test>#{resume.test}</Test>"
      xml += "<ExternalUserID>#{resume.external_user_id}</ExternalUserID>"
      xml += '</Request>'
      xml
    end
  end
end
