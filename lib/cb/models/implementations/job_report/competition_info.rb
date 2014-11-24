module Cb
  module Models
    class CompetitionInfo < ApiResponseModel
      attr_accessor :applications_submitted, :applications_viewed, :percent_exceeds_education_level,
                    :percent_cover_letter_attached, :percent_employed, :experience_ranges, :applicant_locations,
                    :salary_information, :top_five_degrees, :top_five_majors

      def set_model_properties
        @applications_submitted             = api_response['ApplicationsSubmitted']
        @applications_viewed                = api_response['ApplicationsViewed']
        @percent_cover_letter_attached      = api_response['PercentWithCoverLetter']
        @percent_employed                   = api_response['PercentEmployed']
        @percent_exceeds_education_level    = api_response['ExceedsEducation']
        @applicant_locations                = extract_applicant_locations
        @experience_ranges                  = extract_experience_ranges
        @top_five_degrees                   = extract_top_degrees
        @top_five_majors                    = extract_top_majors
        @salary_information                 = extract_salary_information
      end

      def required_fields
        %w(ApplicationsSubmitted ApplicationsViewed PercentWithCoverLetter PercentEmployed ExceedsEducation
            ApplicantLocations ExperienceRanges TopDegrees TopMajors SalaryInformation)
      end

      def extract_applicant_locations
        api_response['ApplicantLocations'].collect do |info|
          Models::Location.new(info)
        end
      end

      def extract_experience_ranges
        api_response['ExperienceRanges'].collect do |info|
          Models::Experience.new(info)
        end
      end

      def extract_top_degrees
        api_response['TopDegrees'].collect do |degree|
          Models::Degree.new(degree)
        end
      end

      def extract_top_majors
        api_response['TopMajors'].collect do |major|
          Models::Major.new(major)
        end
      end

      def extract_salary_information
        Models::Salary.new(api_response['SalaryInformation'])
      end
    end
  end
end
