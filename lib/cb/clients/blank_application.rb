module Cb
	module Clients
		class BlankApplication

			def get(criteria)
				response cb_call(:get, criteria)
			end

			private

			def cb_call(http_method, criteria)
				options = { headers: headers(criteria) }
				uri = Cb.configuration.uri_blank_application

				api_client.method(:"cb_#{http_method}").call uri, options
			end

			def response(response_hash)
				Responses::BlankApplication.new response_hash
			end

			def headers(criteria)
				{
						:DeveloperKey   => Cb.configuration.dev_key,
				    :HostSite       => !criteria[:HostSite].nil? ? criteria[:HostSite] : '',
						:JobDID         => !criteria[:JobDID].nil? ? criteria[:JobDID] : '',
				    :SiteID         => !criteria[:SiteID].nil? ? criteria[:SiteID] : '',
				    :CoBrand        => !criteria[:CoBrand].nil? ? criteria[:CoBrand] : '',
				    'Content-Type'  => 'application.json'
				}
			end

			def api_client
				Cb::Utils::Api.new
			end

		end
	end
end
