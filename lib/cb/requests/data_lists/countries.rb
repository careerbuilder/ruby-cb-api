require_relative 'data_list_base'

module Cb
  module Requests
    module DataLists
      class Countries < DataListBase
        def api_uri
          Cb.configuration.uri_countries
        end
      end
    end
  end
end
