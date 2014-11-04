module Cb
  module Models
    module Resumes
      class LanguageCode < ApiResponseModel
        attr_accessor :code,:name

        def set_model_properties
          @code = api_response['Code']
          @name = api_response['Name']
        end

        def required_fields
          ['Code', 'Name']
        end
      end
    end
  end
end
