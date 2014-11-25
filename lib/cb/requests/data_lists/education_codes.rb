require_relative 'data_list_base'

module Cb
  module Requests
    module DataLists
      class EducationCodes < DataListBase
        def api_uri
          Cb.configuration.uri_resume_education
        end
      end
    end
  end
end
