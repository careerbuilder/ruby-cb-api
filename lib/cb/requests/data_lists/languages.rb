require_relative 'data_list_base'

module Cb
  module Requests
    module DataLists
      class Languages < DataListBase
        def api_uri
          Cb.configuration.languages
        end
      end
    end
  end
end
