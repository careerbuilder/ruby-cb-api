module Cb
  module Models
    class JobInfo < ApiResponseModel
      attr_accessor :company, :days_til_expiration, :degree_required, :experience_required,
                    :job_title

      def set_model_properties
        @company                = Models::Company.new(api_response['Company'])
        @days_til_expiration    = api_response['DaysTilExpire']
        @degree_required        = api_response['DegreeRequired']
        @experience_required    = api_response['ExperienceYearsRequired']
        @job_title              = api_response['JobTitle']
      end

      def required_fields
        %w(Company DaysTilExpire DegreeRequired ExperienceYearsRequired JobTitle)
      end

    end
  end
end
