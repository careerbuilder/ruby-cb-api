module Cb
	class TalentNetworkApi
		####################################################
		## Documentation:
		## http://api.careerbuilder.com/TalentNetwork.aspx
		####################################################

		def self.join_form_questions(tndid)
			## Load the join form questions for a TalentNetworkDID
			my_api = Cb::Utils::Api.new()
			json_hash = my_api.cb_get("#{Cb.configuration.uri_tn_join_questions}/#{tndid}/json")

			tn_questions_collection = TalentNetwork.new(json_hash)
			my_api.append_api_responses(tn_questions_collection, json_hash)

			return tn_questions_collection
		end

		def self.join_form_branding(tndid)
			## Gets branding information (stylesheets, copytext, etc...) for the join form.
			my_api = Cb::Utils::Api.new

			json_hash = my_api.cb_get("#{Cb.configuration.uri_tn_join_form_branding}/#{tndid}/json")

      if json_hash.has_key? 'Branding'
			  tn_join_form_branding = TalentNetwork::JoinFormBranding.new(json_hash['Branding'])
      end

			my_api.append_api_responses(tn_join_form_branding, json_hash)

			return tn_join_form_branding

		end

		def self.join_form_geography(tnlanguage="USEnglish")
			## Gets locations needed to fill the Geography question from the Join Form Question API
			my_api = Cb::Utils::Api.new
			json_hash = my_api.cb_get("#{Cb.configuration.uri_tn_join_form_geo}", :query=>{:TNLanguage=>"#{tnlanguage}"})

			geo_dropdown = TalentNetwork::JoinFormGeo.new(json_hash)
			my_api.append_api_responses(geo_dropdown, json_hash)

			return geo_dropdown
		end

		def self.member_create(args={})
			## Creates a member based on the form built with the Join Form Questions API call
			my_api = Cb::Utils::Api.new
			tn_member = TalentNetwork::Member.new(args)
      json_hash = my_api.cb_post("#{Cb.configuration.uri_tn_member_create}/json", :body => tn_member.to_xml )
      my_api.append_api_responses(json_hash, json_hash)

			return json_hash
		end

		def self.tn_job_information(job_did, join_form_intercept="true")
			my_api = Cb::Utils::Api.new
			json_hash = my_api.cb_get("#{Cb.configuration.uri_tn_job_info}/#{job_did}/json", :query=> {
				 :RequestJoinFormIntercept=>join_form_intercept})

      if json_hash.has_key? 'Response'
			  tn_job_info = TalentNetwork::JobInfo.new(json_hash['Response'])
      end

			my_api.append_api_responses(tn_job_info, json_hash)

			return tn_job_info
		end
	end #TalentNetworkJoinQuestions
end #module