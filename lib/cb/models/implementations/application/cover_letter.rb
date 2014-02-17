module Cb
  module Models
    class Application < ApiResponseModel
      class CoverLetter < ApiResponseModel
        attr_accessor :cover_letter_id, :cover_letter_text, :cover_letter_title

        protected

        def required_fields
          []
        end

        def set_model_properties
          @cover_letter_id = api_response['CoverLetterID']
          @cover_letter_text = api_response['CoverLetterText']
          @cover_letter_title = api_response['CoverLetterTitle']
        end

      end
    end
  end
end
