module Cb
	class CbJob
    attr_accessor :did, :title, :pay,
                  :company_name, :company_did, :company_details_url, :company_image_url, :company,
                  :description_teaser, :location, :distance, :latitude, :longitude,
                  :description, :requirements, :employment_type,
                  :details_url, :service_url, :similar_jobs_url,
                  :begin_date, :end_date, :posted_date

		##############################################################
		## This general purpose object stores anything having to do
    ## with a job. The API objects dealing with job, will populate
    ## one or many of this object.
		##############################################################
    def initialize(args = {})
      # General
      @did                          = args['DID'] || ''
      @title                        = args['JobTitle'] || ''
      @employment_type              = args['EmploymentType'] || ''
      @latitude                     = args['LocationLatitude'] || ''
      @longitude                    = args['LocationLongitude'] || ''
      @pay                          = args['Pay'] || ''

      # Job Search related
      @description_teaser           = args['DescriptionTeaser'] || ''
      @posted_date                  = args['PostedDate'] || ''
      @distance                     = args['Distance'] || ''
      @details_url                  = args['JobDetailsURL'] || ''
      @service_url                  = args['JobServiceURL'] || ''
      @location                     = args['Location'] || ''
      @similar_jobs_url             = args['SimilarJobsURL'] || ''

      # Job Details related
      @description                  = args['Description'] || ''
      @requirements                 = args['JobRequirements'] || ''
      @begin_date                   = args['BeginDate'] || ''
      @end_date                     = args['EndDate'] || ''

      # Company related
      @company_name                 = args['Company'] || ''
      @company_did                  = args['CompanyDID'] || ''
      @company_details_url          = args['CompanyDetailsURL'] || ''
      @company_image_url            = args['CompanyImageURL'] || ''
    end

    def find_company
      if @company
        return @company
      else
        @company = Cb.company_api.find_for self

        return @company
      end
    end
	end
end