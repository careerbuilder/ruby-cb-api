# Copyright 2016 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'json'
require_relative 'base'
module Cb
  module Clients
    class Company < Base
      def self.find_by_did(did)
        json_hash = cb_client.cb_get(Cb.configuration.uri_company_find,
                                     query: { CompanyDID: did, hostsite: Cb.configuration.host_site })

        if json_hash.key?('Results')
          if json_hash['Results'].key?('CompanyProfileDetail')
            company = Models::Company.new(json_hash['Results']['CompanyProfileDetail'])
          end
          cb_client.append_api_responses(company, json_hash['Results'])
        end

        cb_client.append_api_responses(company, json_hash)
      end

      def self.find_for(obj)
        if obj.is_a?(String)
          did = obj
        elsif obj.is_a?(Cb::Models::Job)
          did = obj.company_did
        end
        did ||= ''

        find_by_did did unless did.empty?
      end
    end
  end
end
