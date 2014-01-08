module Cb
  class CbApplication
    #request params
    attr_accessor :job_did, :site_id, :ipath, :co_brand, :test,
                  :resume_file_name, :resume,
                  :user_external_id, :user_external_resume_id,
                  :answers

    #response params
    #redirect_url is returned from the api for shared apply applications.
    attr_accessor :redirect_url

    def initialize(args = {})
      @job_did                  = args[:job_did]
      @site_id                  = args[:site_id] || 'cbnsv'
      @ipath                    = args[:ipath] || ''
      @co_brand                 = args[:co_brand] || ''
      @test                     = args[:test] || 'false'
      @resume_file_name         = args[:resume_file_name] || ''
      @resume                   = args[:resume] || ''
      @user_external_id         = args[:user_external_id] || ''
      @user_external_resume_id  = args[:user_external_resume_id] || ''
      @answers                  = []
      @redirect_url             = ''
    end

    def submit
      if is_registered?
        Cb.application.submit_registered_app(self)
      else
        Cb.application.submit_app(self)
      end
    end

    def is_registered?
      !@user_external_id.blank? && @resume.blank?
    end

    def is_unregistered?
      !is_registered?
    end

    def complete?
      cb_response.application_status == 'Complete' || cb_response.application_status == 'Complete (Test)'
    end

    def add_answer(id, text)
      @answers << CbApplication::CbAnswer.new(id, text)
    end

    def to_xml
      ret = '<RequestApplication>'

      ret = "#{ret}<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>"
      ret = "#{ret}<JobDID>#{@job_did}</JobDID>"
      ret = "#{ret}<Test>#{@test}</Test>" unless @test.blank?
      ret = "#{ret}<SiteID>#{@site_id}</SiteID>" unless @site_id.blank?
      #ret = "#{ret}<IPath>#{@ipath}</IPath>" unless @ipath.blank? #this has to be passed by query string because the api is lame.
      ret = "#{ret}<CoBrand>#{@co_brand}</CoBrand>" unless @co_brand.blank?
      ret = "#{ret}<HostSite>#{Cb.configuration.host_site}</HostSite>"
      ret = "#{ret}<Resume><ResumeFileName>#{@resume_file_name}</ResumeFileName><ResumeData>#{@resume}</ResumeData></Resume>" if is_unregistered?

      unless @answers.count == 0
        ret = "#{ret}<Responses>"
        @answers.each do | ans |
          ret = "#{ret}#{ans.to_xml}"
        end
        ret = "#{ret}</Responses>"
      end

      ret = "#{ret}<ExternalUserID>#{@user_external_id}</ExternalUserID>" if is_registered?
      ret = "#{ret}<ExternalResumeID>#{@user_external_resume_id}</ExternalResumeID>" if is_registered?

      "#{ret}</RequestApplication>"
    end # to_xml
  end # CbApplication

  ############################################################
  class CbApplication::CbAnswer
    attr_accessor :id, :text

    def initialize(id, text)
      @id   = id
      @text = text
    end

    def to_xml
      "<Response><QuestionID>#{@id}</QuestionID><ResponseText>#{@text}</ResponseText></Response>"
    end
  end # CbAnswer
end # Cb