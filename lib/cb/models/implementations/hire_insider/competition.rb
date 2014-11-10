module Cb
  module Models
    module JobReport
      class Competition < ApiResponseModel
        attr_accessor :applications_submitted, :applicantions_viewed, :percent_exceeds_education_level,
                      :percent_meets_education_level, :percent_cover_letter_attached, :percent_employed,
                      :experience_ranges, :applicant_locations, :top_five_degrees, :top_five_majors

        def set_model_properties
          @applications_submitted             = api_response['ApplicationsSubmitted']   || String.new
          @applicantions_viewed               = api_response['ApplicationsViewed']      || String.new
          @percent_exceeds_education_level    = api_response['ExceedsEducation']        || String.new
          @percent_meets_education_level      = api_response['MeetsEducation']          || String.new
          @percent_cover_letter_attached      = api_response['AttachedCoverLetter']     || String.new
          @percent_employed                   = api_response['Employed']                || String.new
          @experience_ranges                  = extract_experience_ranges               || []
          @applicant_locations                = extract_applicant_locations             || []
          @top_five_degrees                   = extract_top_degrees                     || []
          @top_five_majors                    = extract_top_majors                      || []
        end

        def required_fields
          ['Competition']
        end

        def extract_experience_ranges
          unless api_response['ExperienceRanges'].nil?
            api_response['ExperienceRanges'].collect do |info|
              JobReport::Experience.new(info)
            end
          end
        end

        def extract_applicant_locations
          unless api_response['ApplicantLocations'].nil?
            api_response['ApplicantLocations'].collect do |info|
              JobReport::Location.new(info)
            end
          end
        end

        def extract_top_degrees
          unless api_response['TopDegrees'].nil?
            api_response['TopDegrees'].collect do |degree|
              JobReport::Degrees.new(degree)
            end
          end
        end

        def extract_top_majors
          unless api_response['TopMajors'].nil?
            api_response['TopMajors'].collect do |major|
              JobReport::Majors.new(major)
            end
          end
        end

      end
    end
  end
end
