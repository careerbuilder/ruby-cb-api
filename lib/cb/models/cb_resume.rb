module Cb
  class CbResume
    attr_accessor :external_resume_id, :external_user_id,
                  :did, :title, :visibility, :resume_text,
                  :email, :real_name, :gender, :phone, :birth_date,
                  :address, :city, :state, :postal_code, :country_code,
                  :show_contact_info, :test,
                  :created_dt, :modified_dt,
                  :categories, :languages,
                  :company_experiences, :educations,
                  :custom_values

    def initialize(args = {})
      set_attributes(args)
    end

    def set_attributes(args = {})
      return if args.nil?
      @did                      = args['ResumeDID'] || ''
      @email                    = args['Email'] || ''
      @real_name                = args['RealName'] || ''
      @gender                   = args['Gender'] || ''
      @address                  = args['Address'] || ''
      @city                     = args['City'] || ''
      @state                    = args['State'] || ''
      @postal_code              = args['PostalCode'] || ''
      @country_code             = args['CountryCode'] || ''
      @phone                    = args['Phone'] || ''
      @birth_date               = args['BirthDate'] || ''
      @title                    = args['Title'] || ''
      @visibility               = args['Visibility'] || ''
      @show_contact_info        = args['ShowContactInfo'] || ''
      @created_dt               = args['CreatedDT'] || ''
      @modified_dt              = args['ModifiedDT'] || ''
      @categories               = args['Categories'] || ''
      @resume_text              = args['ResumeText'] || ''
      @languages                = !args['Languages'].nil? ? args['Languages']['Language'] : ''
      @stats_searches           = !args['Stats'].nil? ? args['Stats']['Searches'] : -1
      @stats_clicks             = !args['Stats'].nil? ? args['Stats']['Clicks'] : -1
      @stats_applications       = !args['Stats'].nil? ? args['Stats']['Applications'] : -1

      #These don't come back on retrieve
      @external_resume_id       = '' if @external_resume_id.blank?
      @external_user_id         = '' if @external_user_id.blank?

      @test = false

      @company_experiences = []
      if args.has_key?('CompanyExperiences')
        unless args['CompanyExperiences'].empty?
          args['CompanyExperiences']['CompanyExperience'].each do | qq |
            @company_experiences << CbResume::CbCompanyExperience.new(qq)
          end
        end
      end

      @educations = []
      if args.has_key?('Educations')
        unless args['Educations'].empty?
          args['Educations']['Education'].each do | qq |
            @educations << CbResume::CbEducation.new(qq)
          end
        end
      end

      @custom_values = []
      if args.has_key?('CustomValues')
        unless args['CustomValues'].empty?
          args['CustomValues']['CustomValue'].each do | qq |
            @custom_values << CbResume::CbCustomValue.new(qq)
          end
        end
      end
    end

    def load
      Cb.resume.retrieve self
    end

    def add_company_experience(params)
      @company_experiences << CbResume::CbCompanyExperience.new(params)
    end

    def add_education(params)
      @educations << CbResume::CbEducation.new(params)
    end

    def add_custom_value(params)
      @custom_values << CbResume::CbCustomValue.new(params)
    end
  end

  class CbResume::CbCompanyExperience
    attr_accessor :job_title, :company_name, :start_date, :end_date, :is_current, :details

    def initialize(args = {})
      @job_title        = args['JobTitle'] || ''
      @company_name     = args['CompanyName'] || ''
      @start_date       = args['StartDate'] || ''
      @end_date         = args['EndDate'] || ''
      @is_current       = args['IsCurrent'] || ''
      @details          = args['Details'] || ''
    end
  end

  class CbResume::CbEducation
    attr_accessor :school_name, :major, :degree_name, :degree_code, :graduation_date, :gpa

    def initialize(args = {})
      @school_name      = args['SchoolName'] || ''
      @major            = args['Major'] || ''
      @degree_name      = args['DegreeName'] || ''
      @degree_code      = args['DegreeCode'] || ''
      @graduation_date  = args['GraduationDate'] || ''
      @gpa              = args['GPA'] || ''
    end
  end

  class CbResume::CbCustomValue
    attr_accessor :key, :value

    def initialize(args = {})
      @key              = args['Key'] || ''
      @value            = args['Value'] || ''
    end
  end
end