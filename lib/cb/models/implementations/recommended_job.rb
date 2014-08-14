module Cb
  module Models
    class RecommendedJob < ApiResponseModel
      attr_reader :id, :job_title, :city, :admin_area_1, :latitude,
                  :longitude, :company_name, :company_id, :job_details_url,
                  :employment_type, :educations_required, :experience_required,
                  :matcher_id, :pay, :categories, :apply_requirements,
                  :skills, :posted

      def initialize(args={})
        super(args)
      end

      def required_fields
        []
      end

      def set_model_properties
        args = api_response
        @id = args['id']
        @job_title = args['job_title']
        @city = args['city']
        @admin_area_1 = args['admin_area_1']
        @latitude = args['latitude']
        @longitude = args['longitude']
        @company_name = args['company_name']
        @company_id = args['company_id']
        @job_details_url = args['job_details_url']
        @employment_type = args['employment_type']
        @educations_required = args['educations_required']
        @experience_required = args['experience_required']
        @matcher_id = args['matcher_id']
        @pay = args['pay']
        @categories = args['categories']
        @apply_requirements = args['apply_requirements']
        @skills = args['skills']
        @posted = args['posted']
      end
    end
  end
end
