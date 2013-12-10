require 'json'

module Cb
  module Clients
    class Company

      def self.find_by_did(did)
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_get(Cb.configuration.uri_company_find, :query => {:CompanyDID => did, :hostsite=> Cb.configuration.host_site})

        if json_hash.has_key?('Results')
            if json_hash['Results'].has_key?('CompanyProfileDetail')
              company = CbCompany.new(json_hash['Results']['CompanyProfileDetail'])
            end
            my_api.append_api_responses(company, json_hash['Results'])
        end

        my_api.append_api_responses(company, json_hash)
      end

      def self.find_for(obj)
        if obj.is_a?(String)
          did = obj
        elsif obj.is_a?(Cb::CbJob)
          did = obj.company_did
        end
        did ||= ''

        find_by_did did unless did.empty?
      end

    end
  end
end
