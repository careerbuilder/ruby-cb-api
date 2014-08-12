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


    end
  end
end
