module Cb
	module Models
		class BlankApplication < ApiResponseModel
			class Question < ApiResponseModel

				attr_accessor :question_id, :question_type, :is_required,
				              :expected_response_format, :question_text, :answers

				protected

				def required_fields
					%w(QuestionID QuestionType IsRequired ExpectedResponseFormat QuestionText)
				end

				def set_model_properties
					@question_id                    = api_response['QuestionID']
					@question_type                  = api_response['QuestionType']
					@is_required                    = api_response['IsRequired']
					@expected_response_format       = api_response['ExpectedResponseFormat']
					@question_text                  = api_response['QuestionText']
					@answers                        = extract_answers
				end

				def extract_answers
					if !api_response['Answers'].nil?
						api_response['Answers'].map do |response_hash|
							Answer.new response_hash['Answer']
						end
					end
				end

			end
		end
	end
end