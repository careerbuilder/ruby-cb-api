module Cb
  module Models
    class Resume
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
        @stats_searches           = !args['Stats'].nil? ? args['Stats']['Searches'] : -1
        @stats_clicks             = !args['Stats'].nil? ? args['Stats']['Clicks'] : -1
        @stats_applications       = !args['Stats'].nil? ? args['Stats']['Applications'] : -1

        #These don't come back on retrieve
        @external_resume_id       = '' if @external_resume_id.blank?
        @external_user_id         = '' if @external_user_id.blank?

        @test = false

        @company_experiences = []
        if args.has_key?('CompanyExperiences') && !args['CompanyExperiences'].blank?
          ce = args['CompanyExperiences']['CompanyExperience']
          if ce.is_a? Array
            ce.each do | hi |
              @company_experiences << Resume::CompanyExperience.new(hi)
            end
          elsif ce.is_a? Hash
            @company_experiences << Resume::CompanyExperience.new(ce)
          end
        end

        @educations = []
        if args.has_key?('Educations') && !args['Educations'].blank?
          ed = args['Educations']['Education']
          if ed.is_a? Array
            ed.each do | hello |
              @educations << Resume::Education.new(hello)
            end
          elsif ed.is_a? Hash
            @educations << Resume::Education.new(ed)
          end
        end

        @languages = []
        if args.has_key?('Languages') && !args['Languages'].blank?
          la = args['Languages']['Language']
          if la.is_a? Array
            la.each do | greetings |
              @languages << Resume::Language.new(greetings)
            end
          elsif la.is_a? String
            @languages << Resume::Language.new(la)
          end
        end

        @custom_values = []
        if args.has_key?('CustomValues') && !args['CustomValues'].blank?
          cv = args['CustomValues']['CustomValue']
          if cv.is_a? Array
            cv.each do | hola |
              @custom_values << Resume::CustomValue.new(hola)
            end
          elsif cv.is_a? Hash
            @custom_values << Resume::CustomValue.new(cv)
          end
        end
      end

      def add_company_experience(params)
        @company_experiences << Resume::CompanyExperience.new(params)
      end

      def add_education(params)
        @educations << Resume::Education.new(params)
      end

      def add_language(params)
        @languages << Resume::Language.new(params)
      end

      def add_custom_value(params)
        @custom_values << Resume::CustomValue.new(params)
      end

      def custom_value custom_value_key
        custom_value = ""

        @custom_values.each do |cv|
          custom_value = cv.value if cv.key == custom_value_key
        end

        return custom_value
      end

      def current_employed
        custom_value "CURR_EMPLYD"
      end

      def desired_job_type
        custom_value "DES_JOB_TYP"
      end

      def experience_in_months
        custom_value "EXP_MNS"
      end

      def job_type
        custom_value "JOB_TYP"
      end

      def recent_income
        custom_value "RCNT_INCM"
      end

      def recent_income_currency_type
        custom_value "RCNT_INCM_CRCY_TYP"
      end

      def recent_income_type
        custom_value "RCNT_INCM_TYP"
      end

      def it_skill
        custom_value "IT_SKILLS"
      end

      def certifications
        custom_value "CERTS"
      end

      def management_experience
        custom_value "MGMT_EXP"
      end

      def lang_prof(id_lang)
        custom_value "LANG_PROF" + id_lang
      end

      def langs
        custom_value "LANGS"
      end

      def lang(id_lang)
        custom_value "LANG" + id_lang
      end
    end

    class Resume::CompanyExperience
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

    class Resume::Education
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

    class Resume::Language
      attr_accessor :name

      def initialize(code = '')
        @name             = code
      end
    end

    class Resume::CustomValue
      attr_accessor :key, :value

      def initialize(args = {})
        @key              = args['Key'] || ''
        @value            = args['Value'] || ''
      end
    end
  end
end
