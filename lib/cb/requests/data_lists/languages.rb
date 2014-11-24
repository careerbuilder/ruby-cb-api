module Cb
  module Requests
    module DataLists
      class Languages < DataListBase
        def base_uri
          Cb.configuration.languages
        end
      end
    end
  end
end
