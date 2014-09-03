module Cb
  module Models
    module Resumes
      class Relocation < ApiResponseModel
        attr_accessor :city, :admin_area, :country_code

        def set_model_properties
          @city = api_response['city']
          @admin_area = api_response['adminArea']
          @country_code = api_response['countryCode']
        end

        def required_fields
          ['city', 'adminArea', 'countryCode']
        end
      end
    end
  end
end
