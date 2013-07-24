module Cb
	class TalentNetwork
		####################################################
		## Documentation:
		## http://api.careerbuilder.com/TalentNetwork.aspx
		####################################################

		def self.join_form_questions(tndid, responsetype)
			## Load the join form questions for a TalentNetworkDID
			responsetype = 'xml' if responsetype.blank?
			my_api = Cb::Utils::Api.new()
			cb_response = my_api.cb_get("#{Cb.configuration.uri_tn_join_questions}/#{tndid}/#{responsetype}")
		end

		def self.join_form_branding
			## Gets branding information (stylesheets, copytext, etc...) for the join form.
		end

		def self.join_form_geography
			## Gets locations needed to fill the Geography question from the Join Form Question API
		end

		def self.member_create
			## Creates a member based on the form built with the Join Form Questions API call
		end

	end #TalentNetworkJoinQuestions
end #module