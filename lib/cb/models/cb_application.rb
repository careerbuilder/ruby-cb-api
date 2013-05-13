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

    end
  end # CbApplication

  ############################################################
  class CbApplication::CbAnswer
    attr_accessor :id, :text

    def initialize(id, text)
      @id               = id
      @text             = text
    end
  end # CbAnswer
end # Cb