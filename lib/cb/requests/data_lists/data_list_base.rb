module Cb
  module Requests
    module DataLists
      class DataListBase
        attr_reader :token, :args

        def initialize(token, args)
          @token = token
          @args = args
        end

        def get
          Cb::Responses::ResumeDataList.new request.parsed
        end

        def api_uri
          raise NotImplementedError.new __method__
        end

        private

        def request
          token.get(uri)
        end

        def uri
          base_uri + query_string
        end

        def base_uri
          Cb.configuration.base_uri + api_uri
        end

        def query_string
          args['countrycode'] ? "?countrycode=#{args['countrycode']}" : '?countrycode=US'
        end
      end
    end
  end
end