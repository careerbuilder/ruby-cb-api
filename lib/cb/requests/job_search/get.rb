module  Cb
  module Requests
    module JobSearch
      class Get < Base
        
        def endpoint_uri
          Cb.configuration.uri_job_search_v3
        end
        
        def http_method
          :get
        end
        
        def headers
          {
            'Authorization' => args[:three_scale_token].nil? ? '' : "Bearer #{args[:three_scale_token]}",
            'HostSite' => args[:host_site] || Cb.configuration.host_site,
            'Accept' => 'applicatin/json;version=3.0'
          }
        end
        
        def query
          args.except(:three_scale_token)
        end
      end
    end
  end
end
