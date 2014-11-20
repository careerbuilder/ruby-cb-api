module Cb
  module Requests
    module DataLists
      class EducationCodes
        attr_reader :token, :args

        def initialize(token, args)
          @token = token
          @args = args
        end

        def get
          Cb::Responses::EducationCodes.new request.parsed
        end

        private

        def request
          token.get(uri)
        end

        def uri
          base_uri + query_string
        end

        def base_uri
          Cb.configuration.base_uri + Cb.configuration.uri_education_codes
        end

        def query_string
          args['countrycode'] ? "?countrycode=#{args['countrycode']}" : '?countrycode=US'
        end
      end
    end
  end
end
