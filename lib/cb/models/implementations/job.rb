module Cb
  module Models
    class Job
      attr_accessor :did, :title, :job_skin, :job_skin_did, :job_branding, :pay, :pay_per, :commission, :bonus, :pay_other,
                    :categories, :category_codes, :degree_required, :experience_required, :travel_required,
                    :industry_codes, :manages_others_code,
                    :contact_email_url, :contact_fax, :contact_name, :contact_phone,
                    :company_name, :company_did, :company_details_url, :company_image_url, :company,
                    :description_teaser, :external_apply_url, :job_tracking_url, :location, :distance, :latitude, :longitude, :location_formatted,
                    :description, :requirements, :employment_type,
                    :details_url, :service_url, :similar_jobs_url, :apply_url,
                    :begin_date, :end_date, :posted_date,
                    :relevancy, :state, :city, :zip,
                    :can_be_quick_applied, :apply_requirements,
                    :divison, :industry, :location_street_1, :relocation_options, :location_street_2, :display_job_id,
                    :manages_others_string,
                    :degree_required_code, :travel_required_code, :employment_type_code

      attr_writer   :external_application, :is_screener_apply,
                    :is_shared_job,
                    :relocation_covered, :manages_others

      def initialize(args = {})
        return if args.nil?

        # General
        @did                          = args['DID'] || args['JobDID'] || ''
        @title                        = args['JobTitle'] || args['Title'] || ''
        @employment_type              = args['EmploymentType'] || ''
        @employment_type_code         = args['EmploymentTypeCode'] || ''
        @latitude                     = args['LocationLatitude'] || ''
        @longitude                    = args['LocationLongitude'] || ''
        @location_street_1            = args['LocationStreet1'] || ''
        @location_street_2            = args['LocationStreet2'] || ''
        @location_formatted           = args['LocationFormatted'] || ''

        # Job Skin Related
        @job_skin                     = args.has_key?("JobSkin") && !args["JobSkin"].nil? ? args['JobSkin']['#cdata-section'] : ''
        @job_skin_did                 = args['JobSkinDID'] || ''
        @job_branding                 = @job_skin_did.empty? ? '' : Cb.job_branding.find_by_id(job_skin_did)
        @job_tracking_url             = args['JobTrackingURL'] || ''
        @display_job_id               = args['DisplayJobID'] || ''

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
        @degree_required              = args['DegreeRequired'] || ''
        @degree_required_code         = args['DegreeRequiredCode'] || ''
        @experience_required          = args['ExperienceRequired'] || ''
        @experience_required_code     = args['ExperienceRequiredCode'] || ''
        @travel_required              = args['TravelRequired'] || ''
        @travel_required_code         = args['TravelRequiredCode'] || ''
        @relocation_covered           = args['RelocationCovered'] || ''
        @relocation_options           = args['RelocationOptions'] || ''
        @division                     = args['Division'] || ''
        @industry                     = args['Industry'] || ''
        @industry_codes               = args['IndustryCodes'] || ''
        @manages_others               = args['ManagesOthers'] || ''
        @manages_others_code          = args['ManagesOthersCode'] || ''
        @manages_others_string        = args['ManagesOthersString'] || ''

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
        @external_apply_url           = args['ExternalApplyURL'] || ''
        @external_application         = args['ExternalApplication'] || ''
        @is_screener_apply            = args['IsScreenerApply'] || ''
        @is_shared_job                = args['IsSharedJob'] || ''
        @can_be_quick_applied         = args['CanBeQuickApplied'] || ''
        @apply_requirements           = Cb::Utils::ResponseArrayExtractor.extract(args, 'ApplyRequirements')

        # Company related
        @company_did                  = args['CompanyDID'] || ''
        @company_image_url            = args['CompanyImageURL'] || ''

        # Recommendations related
        @relevancy                    = args['Relevancy'] || ''
        @state                        = args['LocationState'] || ''
        @city                         = args['LocationCity'] || ''
        @zip                          = args['LocationPostalCode'] || ''

        @company_name            = figure_out_company_info(args['Company'],args['Company'],'CompanyName')
        @company_details_url     = figure_out_company_info(args['CompanyDetailsURL'],args['Company'],'CompanyDetailsURL')


        load_extra_fields(args)


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

      def can_be_quick_applied?
        @can_be_quick_applied.downcase == 'true' ? true : false
      end

      def city
        if @city.empty?
          return @location['City']
        else
          return @city
        end
      end

      def state
        if @state.empty?
          return @location['State']
        else
          return @state
        end
      end

      protected

      def load_extra_fields(args)
        #for internal use only :)
      end

      private

      def figure_out_company_info(job_search, recommendation, rec_key)
        #Job Search and Recommendations both use this class as a model. Unfortunately, they both return company_name and
        # company_details_url in different ways. Job search returns it in args[company] and args[company_details_url],
        # but recommendations returns it in args[company][key]. This has been ticketed to the API team, and this logic
        # will be removed when they have fixed the issue.
        if job_search.class != Hash && job_search != ""
          return job_search
        elsif recommendation.class == Hash && !recommendation[rec_key].nil?
          return recommendation[rec_key]
        else
          return ''
        end

      end

    end
  end
end
