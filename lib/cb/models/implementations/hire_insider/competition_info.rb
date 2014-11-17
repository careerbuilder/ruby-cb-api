module Cb
  module Models
    module HireInsider
      class CompetitionInfo < ApiResponseModel
        attr_accessor :applications_submitted, :applications_viewed, :percent_exceeds_education_level,
                      :percent_meets_education_level, :percent_cover_letter_attached, :percent_employed,
                      :experience_ranges, :applicant_locations, :top_five_degrees, :top_five_majors

        def set_model_properties
          @applications_submitted             = api_response['ApplicationsSubmitted']
          @applications_viewed                = api_response['ApplicationsViewed']
          @percent_exceeds_education_level    = api_response['ExceedsEducation']
          @percent_meets_education_level      = api_response['MeetsEducation']
          @percent_cover_letter_attached      = api_response['AttachedCoverLetter']
          @percent_employed                   = api_response['PercentEmployed']
          @experience_ranges                  = extract_experience_ranges
          @applicant_locations                = extract_applicant_locations
          @top_five_degrees                   = extract_top_degrees
          @top_five_majors                    = extract_top_majors
        end

        def required_fields
          %w(ApplicationsSubmitted ApplicationsViewed ExceedsEducation MeetsEducation AttachedCoverLetter
            PercentEmployed ExperienceRanges ApplicantLocations TopDegrees TopMajors)
        end

        def extract_experience_ranges
          api_response['ExperienceRanges'].collect do |info|
            HireInsider::Experience.new(info)
          end
        end

        def extract_applicant_locations
          api_response['ApplicantLocations'].collect do |info|
            HireInsider::Location.new(info)
          end
        end

        def extract_top_degrees
          api_response['TopDegrees'].collect do |degree|
            HireInsider::Degree.new(degree)
          end
        end

        def extract_top_majors
          api_response['TopMajors'].collect do |major|
            HireInsider::Major.new(major)
          end
        end

      end
    end
  end
end
