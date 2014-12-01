require_relative 'data_list_base'

module Cb
  module Requests
    module DataLists
      class DesiredJobType < DataListBase
        def api_uri
          Cb.configuration.uri_desired_job_type
        end
      end
    end
  end
end
