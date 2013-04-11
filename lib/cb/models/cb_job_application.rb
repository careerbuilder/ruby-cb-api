module Cb
  class CbJobApplication
    attr_accessor :job_did, :site_id, :co_brand, :apply_url, :title, :total_questions,
                  :total_required_questions, :questions, :submit_service_url
    
    ##############################################################
    ## This general purpose object stores anything having to do
    ## with an application. The API objects dealing with application,
    ## will populate this object.
    ##############################################################
    def initialize(args = {})
      return if args.nil?

      @job_did                      = args['JobDID'] || ''
      @site_id                      = args['SiteID'] || ''
      @co_brand                     = args['CoBrand'] || ''
      @apply_url                    = args['ApplyURL'] || ''
      @title                        = args['JobTitle'] || ''
      @total_questions              = args['TotalQuestions'] || ''
      @total_required_questions     = args['TotalRequiredQuestions'] || ''
      @questions                    = args['Questions'] || ''
      @submit_service_url           = args['ApplicationSubmitServiceURL'] || ''
      
      #TODO
      # Questions needs to be an array of data containers (of question)
      
    end
  end # CbJobApplication
end # Cb