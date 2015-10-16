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
require 'cb/client/base'

module CB
  module Client
    class Company < CB::Client::Base
      COMPANY_DETAILS_ENDPOINT = '/Employer/CompanyDetails'

      def find_by_did(did, host_site = '')
        get(COMPANY_DETAILS_ENDPOINT, query: query_plus_host_site(host_site, CompanyDID: did))
      end
    end
  end
end
