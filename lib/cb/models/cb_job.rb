module Cb
	class CbJob
    attr_accessor :did, :title, :job_skin, :job_skin_did, :job_branding, :pay, :pay_per, :commission, :bonus, :pay_other,
                  :categories, :category_codes, :degree_required, :experience_required, :travel_required,
                  :industry_codes, :manages_others_code,
                  :contact_email_url, :contact_fax, :contact_name, :contact_phone,
                  :company_name, :company_did, :company_details_url, :company_image_url, :company,
                  :description_teaser, :location, :distance, :latitude, :longitude, :location_formatted,
                  :description, :requirements, :employment_type,
                  :details_url, :service_url, :similar_jobs_url, :apply_url,
                  :begin_date, :end_date, :posted_date,
                  :relevancy, :state, :city, :zip

    attr_writer   :external_application, :relocation_covered, :manages_others, :is_screener_apply,
                  :is_shared_job

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
      @job_skin                     = args.has_key?("JobSkin") && !args["JobSkin"].nil? ? args['JobSkin']['#cdata-section'] : ''
      @job_skin_did                 = args['JobSkinDID'] || ''
      @job_branding                 = @job_skin_did.blank? ? '' : Cb.job_branding.find_by_id(job_skin_did)

      # Compensation
      @pay                          = args['PayHighLowFormatted'] || ''
      @pay_per                      = args['PayPer'] || ''
      @commission                   = args.has_key?("PayCommission") && !args["PayCommission"].nil? ? args['PayCommission']['Money']['FormattedAmount'] : ''
      @bonus                        = args.has_key?("PayBonus") && !args["PayBonus"].nil? ? args['PayBonus']['Money']['FormattedAmount'] : ''
      @pay_other                    = args.has_key?("PayOther") && !args["PayOther"].nil? ? args['PayOther'] : ''
      
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

      # Contact Info
      @contact_email_url            = args['ContactInfoEmailURL'] || ''
      @contact_fax                  = args['ContactInfoFax'] || ''
      @contact_name                 = args['ContactInfoName'] || ''
      @contact_phone                = args['ContactInfoPhone'] || ''

      # Job Details related
      @description                  = args['Description'] || args['JobDescription'] || ''
      @requirements                 = args['JobRequirements'] || ''
      @begin_date                   = args['BeginDate'] || ''
      @end_date                     = args['EndDate'] || ''

      # Application
      @apply_url                    = args['ApplyURL'] || ''
      @external_application         = args['ExternalApplication'] || ''
      @is_screener_apply            = args['IsScreenerApply'] || ''
      @is_shared_job                = args['IsSharedJob'] || ''

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

    def screener_apply?
      @is_screener_apply.downcase == 'true' ? true : false
    end

    def shared_job?
      @is_shared_job.downcase == 'true' ? true : false
    end
  end
end