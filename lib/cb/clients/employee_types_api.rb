require "json"

module Cb
  module Clients
    class EmployeeTypesApi

      def self.search
        my_api = Cb::Utils::Api.new()
        json_hash = my_api.cb_get(Cb.configuration.uri_employee_types)

        return array_of_objects_from_hash(json_hash, my_api)
      end

      def self.search_by_host_site(hostsite)
        my_api = Cb::Utils::Api.new()
        json_hash = my_api.cb_get(Cb.configuration.uri_employee_types, :query => {:CountryCode => hostsite})

        return array_of_objects_from_hash(json_hash, my_api)
      end

      private
      def self.array_of_objects_from_hash(json_hash, my_api)

        employee_types = []
        if json_hash.has_key?('ResponseEmployeeTypes')
          if json_hash['ResponseEmployeeTypes'].has_key?('EmployeeTypes') &&
              !json_hash['ResponseEmployeeTypes']['EmployeeTypes'].nil?

            if json_hash['ResponseEmployeeTypes']['EmployeeTypes']['EmployeeType'].is_a?(Array)

              json_hash['ResponseEmployeeTypes']['EmployeeTypes']['EmployeeType'].each do |et|
                employee_types << CbEmployeeType.new(et)
              end

            elsif json_hash['ResponseEmployeeTypes']['EmployeeTypes']['EmployeeType'].is_a?(Hash) && json_hash.length < 2
              employee_types << CbEmployeeType.new(json_hash['ResponseEmployeeTypes']['EmployeeTypes']['EmployeeType'])
            end

          end
          my_api.append_api_responses(employee_types, json_hash['ResponseEmployeeTypes'])
        end

        my_api.append_api_responses(employee_types, json_hash)

        return employee_types
      end

    end
  end
end
