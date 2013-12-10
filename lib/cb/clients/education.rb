require 'json'

module Cb
  module Clients
    class Education

      def self.get_for(country)
        Cb::Utils::Country.is_valid? country ? country : 'US'
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_get(Cb.configuration.uri_education_code, :query => {:countrycode => country})

        codes = []
        if json_hash.has_key?('ResponseEducationCodes')
          if json_hash['ResponseEducationCodes'].has_key?('EducationCodes') &&
             json_hash['ResponseEducationCodes']['EducationCodes'].has_key?('Education')
              json_hash['ResponseEducationCodes']['EducationCodes']['Education'].each do | education |
                codes << Cb::CbEducation.new(education)
              end
          end
          my_api.append_api_responses(codes, json_hash['ResponseEducationCodes'])
        end

        my_api.append_api_responses(codes, json_hash)
      end

    end
  end
end
