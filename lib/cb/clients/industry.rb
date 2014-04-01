require "json"

module Cb
  module Clients
    class Industry

      def self.search
        my_api = Cb::Utils::Api.instance
        json_hash = my_api.cb_get(Cb.configuration.uri_job_industry_search)
        industryList = []

        if json_hash.has_key?('ResponseIndustryCodes')
          if json_hash['ResponseIndustryCodes'].has_key?('IndustryCodes')
            json_hash['ResponseIndustryCodes']['IndustryCodes']['IndustryCode'].each do |indy|
              industryList << Models::Industry.new(indy)
            end
          end

          my_api.append_api_responses(industryList, json_hash['ResponseIndustryCodes'])
        end

        my_api.append_api_responses(industryList, json_hash)
      end

      def self.search_by_host_site(host_site)
        my_api = Cb::Utils::Api.instance
        json_hash = my_api.cb_get(Cb.configuration.uri_job_industry_search, :query => {:CountryCode => host_site})
        industryList = []

        if json_hash.has_key?('ResponseIndustryCodes')
          if json_hash['ResponseIndustryCodes'].has_key?('IndustryCodes')
            if json_hash['ResponseIndustryCodes']['IndustryCodes']['IndustryCode'].is_a?(Array)
              json_hash['ResponseIndustryCodes']['IndustryCodes']['IndustryCode'].each do |indy|
                industryList << Models::Industry.new(indy)
              end
            elsif json_hash['ResponseIndustryCodes']['IndustryCodes']['IndustryCode'].is_a?(Hash) && json_hash.length < 2
              industryList << Models::Industry.new(json_hash['ResponseIndustryCodes']['IndustryCodes']['IndustryCode'])
            end
          end

          my_api.append_api_responses(industryList, json_hash['ResponseIndustryCodes'])
        end

        my_api.append_api_responses(industryList, json_hash)
      end

    end
  end
end
