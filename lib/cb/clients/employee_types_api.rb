require "json"

module Cb
	class EmployeeTypesApi

		def self.search
			my_api = Cb::Utils::Api.new()
			cb_response = my_api.cb_get(Cb.configuration.uri_employee_types)
			
			return array_of_objects_from_hash(cb_response)
		end

		def self.search_by_host_site(hostsite)
			my_api = Cb::Utils::Api.new()
			cb_response = my_api.cb_get(Cb.configuration.uri_employee_types, :query => {:CountryCode => hostsite})

			return array_of_objects_from_hash(cb_response)
		end

		private
		def self.array_of_objects_from_hash(cb_response)
			json_hash = JSON.parse(cb_response.response.body)

			employee_types = []
			unless json_hash.empty?
				if json_hash["ResponseEmployeeTypes"]["EmployeeTypes"]["EmployeeType"].is_a?(Array)
					json_hash["ResponseEmployeeTypes"]["EmployeeTypes"]["EmployeeType"].each do |et|
						employee_types << CbEmployeeType.new(et)
					end
				elsif json_hash["ResponseEmployeeTypes"]["EmployeeTypes"]["EmployeeType"].is_a?(Hash) && json_hash.length < 2
					employee_types << CbEmployeeType.new(json_hash["ResponseEmployeeTypes"]["EmployeeTypes"]["EmployeeType"])
				end
			end
			
			return employee_types
		end

	end
end