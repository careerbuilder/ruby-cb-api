module Cb
  module Models
    module Resumes
      class Relocation < ApiResponseModel
        attr_accessor :city, :state_province, :country

        def set_model_properties
          args = api_response
          @city = args['city']
          @state_province = args['stateProvince']
          @country = args['country']
        end

        def required_fields
          ['city', 'stateProvince', 'country']
        end
      end
    end
  end
end