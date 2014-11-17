module Cb
  module Models
    class JobReport < ApiResponseModel
      attr_accessor :applicant_information, :job_information, :competition_information

      def initialize(args = {})
        super(args)
      end

      def set_model_properties
        @applicant_information      = extract_applicant_info     || []
        @job_information            = extract_job_info           || []
        @competition_information    = extract_competition_info   || []
      end

      def required_fields
        %w(ApplicantInformation JobInformation Competition)
      end

      private

      def extract_applicant_info
        HireInsider::ApplicantInfo.new(api_response['ApplicantInformation'])
      end

      def extract_job_info
        HireInsider::JobInfo.new(api_response['JobInformation'])
      end

      def extract_competition_info
        HireInsider::CompetitionInfo.new(api_response['Competition'])
      end

    end
  end
end
