module Cb
	module Models
		class BlankApplication < ApiResponseModel

			attr_accessor :application_submit_service_url, :apply_url, :job_did, :job_title,
			              :total_questions, :total_required_questions, :questions

			protected

			def required_fields
				%w(JobDID)
			end

			def set_model_properties
				@application_submit_service_url     = api_response['ApplicationSubmitServiceURL'] || ''
				@apply_url                          = api_response['ApplyURL'] || ''
				@job_did                            = api_response['JobDID'] || ''
				@job_title                          = api_response['JobTitle'] || ''
				@total_questions                    = api_response['TotalQuestions'] || ''
				@total_required_questions           = api_response['TotalRequiredQuestions'] || ''
				@questions                          = extract_questions
			end

			private

			def extract_questions
				api_response['Questions'].map do |response_hash|
					Question.new response_hash['Question']
				end
			end

		end
	end
end
