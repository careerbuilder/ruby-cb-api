module Cb
  module Models
    module Resumes
      class Relocation < ApiResponseModel
        attr_accessor :city, :admin_area, :country_code

        def set_model_properties
          args = api_response
          @city = args['city']
          @admin_area = args['adminArea']
          @country_code = args['countryCode']
        end

        def required_fields
          ['city', 'adminArea', 'countryCode']
        end
      end
    end
  end
end
