module Cb
  module Models
    class Application < ApiResponseModel
      class Response < ApiResponseModel
        attr_accessor :question_id, :response_text

        protected

        def required_fields
          %w(QuestionID ResponseText)
        end

        def set_model_properties
          @question_id = api_response['QuestionID']
          @response_text = api_response['ResponseText']
        end

      end
    end
  end
end
