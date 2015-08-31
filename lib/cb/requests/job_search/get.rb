module  Cb
  module Requests
    module JobSearch
      class Get < Base
        attr_reader :token
        
        def initialize(argument_hash, token)
          super(argument_hash)
          @token = token
        end
        
        def endpoint_uri
          Cb.configuration.uri_job_search_v3
        end
        
        def http_method
          :get
        end
        
        def headers
          {
            'HostSite' => args[:host_site] || Cb.configuration.host_site,
            'Accept' => 'applicatin/json;version=3.0'
          }.merge(token.headers)
        end
        
        def query
          args
        end
        
      end
    end
  end
end
