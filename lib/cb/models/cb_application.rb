module Cb
  class CbApplication
    attr_accessor :job_did, :site_id, :co_brand, :test,
                  :resume_file_name, :resume_file,
                  :answers

    def initialize(job_did, site_id = '', co_brand = '', resume_file_name = '', resume = nil, test = false)
      @job_did          = job_did
      @site_id          = site_id
      @co_brand         = co_brand
      @test             = test
      @resume_file_name = resume_file_name
      @resume           = resume
      @answers          = []
    end

    def add_answer(id, text)
      @answers << CbApplication::CbAnswer.new(id, text)
    end

    def to_xml
      ret = '<RequestApplication>'

      ret = "#{ret}<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>"
      ret = "#{ret}<JobDID>#{@job_did}</JobDID>"
      ret = "#{ret}<Test>#{@test}</Test>"
      ret = "#{ret}<SiteID>#{@site_id}</SiteID>"
      ret = "#{ret}<CoBrand>#{@co_brand}</CoBrand>"
      ret = "#{ret}<Resume><ResumeFileName>#{@resume_file_name}</ResumeFileName><ResumeData>#{@resume}</ResumeData></Resume>" unless @resume.nil?

      unless @answers.count == 0
        ret = "#{ret}<Responses>"
        @answers.each do | ans |
          ret = "#{ret}#{ans.to_xml}"
        end
        ret = "#{ret}</Responses>"
      end

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