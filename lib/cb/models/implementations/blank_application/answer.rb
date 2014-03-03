module Cb
	module Models
		class BlankApplication < ApiResponseModel
			class Question < ApiResponseModel
				class Answer < ApiResponseModel

					attr_accessor :question_id, :answer_id, :answer_text

					def required_fields
						%w(QuestionID AnswerID AnswerText)
					end

					def set_model_properties
						@question_id              = api_response['QuestionID']
						@answer_id                = api_response['AnswerID']
						@answer_text              = api_response['AnswerText']
					end

				end
			end
		end
	end
end