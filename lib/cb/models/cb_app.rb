module Cb
	class CbApp
		attr_accessor 	:response_blank_app, :blank_app, :did, :submit_service_url, 
						:apply_url, :title, 
						:total_questions, :total_required_questions, 
						:question_id, :is_required, :question_type, :expected_response_format, 
						:question_text
		#################################################################
		## This general purpose object stores anything having to do with 
    	## an application. The API objects dealing with application, 	
    	## will populate one or many of this object.
		#################################################################

		def initialize(args = {})

			# App related
			@response_blank_app			= args['ResponseBlankApplication'] || ''
			@blank_app  				= args['BlankApplication'] || ''

			# Job Info related
			@did                        = args['DID'] || args['JobDID'] || ''
			@title       			    = args['JobTitle'] || ''

			# Job Details related
			@submit_service_url         = args['ApplicationSubmitServiceURL'] || ''
			@apply_url       			= args['ApplyURL'] || ''
			

			# Question related
			@total_questions       		= args['TotalQuestions'] || ''
			@total_required_questions	= args['TotalRequiredQuestions'] || ''
			@question_id				= args['QuestionID'] || ''
			@is_required				= args['IsRequired'] || ''		 
			@question_type				= args['QuestionType'] || ''				
			@question_text				= args['QuestionText'] || ''
			@expected_response_format	= args['ExpectedResponseFormat'] || ''
		end
	end
end