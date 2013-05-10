module Cb
	class CbJob
    attr_accessor :did, :title, :job_skin, :external_application, :pay, :pay_per, :commission, :bonus,
                  :categories, :category_codes, :degree_required, :experience_required, :travel_required,
                  :relocation_covered, :industry_codes, :manages_others, :manages_others_code,
                  :company_name, :company_did, :company_details_url, :company_image_url, :company,
                  :description_teaser, :location, :distance, :latitude, :longitude, :location_formatted,
                  :description, :requirements, :employment_type,
                  :details_url, :service_url, :similar_jobs_url, :apply_url,
                  :begin_date, :end_date, :posted_date,
                  :relevancy, :state, :city, :zip

		##############################################################
		## This general purpose object stores anything having to do
    ## with a job. The API objects dealing with job, will populate
    ## one or many of this object.
		##############################################################
    def initialize(args = {})
      return if args.nil?

      # General
      @did                          = args['DID'] || args['JobDID'] || ''
      @title                        = args['JobTitle'] || args['Title'] || ''
      @employment_type              = args['EmploymentType'] || ''
      @latitude                     = args['LocationLatitude'] || ''
      @longitude                    = args['LocationLongitude'] || ''
      @location_formatted           = args['LocationFormatted'] || ''
      @job_skin                     = args['JobSkin'] || ''

      # Compensation
      @pay                          = args['PayHighLowFormatted'] || ''
      @pay_per                      = args['PayPer'] || ''
      @commission                   = args['PayCommission']['Money']['FormattedAmount'] || ''
      @bonus                        = args['PayBonus']['Money']['FormattedAmount'] || ''

      # Job Search related
      @description_teaser           = args['DescriptionTeaser'] || ''
      @posted_date                  = args['PostedDate'] || ''
      @distance                     = args['Distance'] || ''
      @details_url                  = args['JobDetailsURL'] || ''
      @service_url                  = args['JobServiceURL'] || ''
      @location                     = args['Location'] || ''
      @similar_jobs_url             = args['SimilarJobsURL'] || ''

      # Summary
      @categories                   = args['Categories'] || ''
      @category_codes               = args['CategoriesCodes'] || ''
      @degree_required              = args['DegreeRequiredCode'] || ''
      @experience_required          = args['ExperienceRequiredCode'] || ''
      @travel_required              = args['TravelRequiredCode'] || ''
      @relocation_covered           = args['RelocationCovered'] || ''
      @industry_codes               = args['IndustryCodes'] || ''
      @manages_others               = args['ManagesOthers'] || ''
      @manages_others_code          = args['ManagesOthersCode'] || ''

      # Job Details related
      @description                  = args['Description'] || args['JobDescription'] || ''
      @requirements                 = args['JobRequirements'] || ''
      @begin_date                   = args['BeginDate'] || ''
      @end_date                     = args['EndDate'] || ''
      @apply_url                    = args['ApplyURL'] || ''
      @external_application         = args['ExternalApplication'] || ''

      # Company related
      @company_name                 = args['Company'] || ''
      @company_did                  = args['CompanyDID'] || ''
      @company_details_url          = args['CompanyDetailsURL'] || ''
      @company_image_url            = args['CompanyImageURL'] || ''

      # Recommendations related
      @relevancy                    = args['Relevancy'] || ''
      @state                        = args['LocationState'] || ''
      @city                         = args['LocationCity'] || ''
      @zip                          = args['LocationPostalCode'] || ''
      @company_name                 = args['Company']['CompanyName'] unless args['Company'].nil? || args['Company']['CompanyName'].nil?
      @company_details_url          = args['Company']['CompanyDetailsURL'] unless args['Company'].nil? || args['Company']['CompanyDetailsURL'].nil?
    end

    def find_company
      if @company
        return @company
      else
        @company = Cb::CompanyApi.find_for self

        return @company
      end
    end

    def external_application?
      @external_application.downcase == 'true' ? true : false
    end

    def relocation_covered?
      @relocation_covered.downcase == 'true' ? true : false
    end

    def manages_others?
      @manages_others.downcase == 'true' ? true : false
    end
  end
end