require 'cb/responses/api_response'
module Cb
	module Responses
		class BlankApplication < ApiResponse

			protected

			def hash_containing_metadata
				response['ResponseBlankApplication']['BlankApplication']
			end

			def validate_api_hash
				required_response_field('BlankApplication', response['ResponseBlankApplication'])
			end

			def extract_models
				Cb::Models::BlankApplication.new response['ResponseBlankApplication']['BlankApplication']
			end

		end
	end
end