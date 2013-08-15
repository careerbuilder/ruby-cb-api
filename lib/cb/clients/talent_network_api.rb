module Cb
	class TalentNetworkApi
		####################################################
		## Documentation:
		## http://api.careerbuilder.com/TalentNetwork.aspx
		####################################################

		def self.join_form_questions(tndid, responsetype="xml")
			## Load the join form questions for a TalentNetworkDID
		
			my_api = Cb::Utils::Api.new()
			cb_response = my_api.cb_get("#{Cb.configuration.uri_tn_join_questions}/#{tndid}/#{responsetype}", :query=>{:DeveloperKey=>Cb.configuration.dev_key})
			p cb_response
		end

		def self.join_form_branding(tndid, responsetype="json")
			## Gets branding information (stylesheets, copytext, etc...) for the join form.
		end

		def self.join_form_geography(tnlanguage="USEnglish")
			## Gets locations needed to fill the Geography question from the Join Form Question API
		end

		def self.member_create
			## Creates a member based on the form built with the Join Form Questions API call
		end

		def self.tn_job_information(job_did, responsetype="json")
			
		end
	end #TalentNetworkJoinQuestions
end #module