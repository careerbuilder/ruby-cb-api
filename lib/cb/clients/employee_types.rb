# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
module Cb
  module Clients
    class EmployeeTypes
      def search
        json = cb_client.cb_get(endpoint)
        new_response_object(json)
      end

      def search_by_hostsite(host_site)
        json = cb_client.cb_get(endpoint, query: { CountryCode: host_site })
        new_response_object(json)
      end

      private

      def cb_client
        @client ||= Cb::Utils::Api.instance
      end

      def endpoint
        Cb.configuration.uri_employee_types
      end

      def new_response_object(json_response)
        Responses::EmployeeTypes::Search.new(json_response)
      end
    end
  end
end
