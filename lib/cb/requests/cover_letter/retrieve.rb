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
require 'cb/requests/base'

module Cb
  module Requests
    module CoverLetter
      class Retrieve < Base
        def endpoint_uri
          Cb.configuration.uri_cover_letter_retrieve
        end

        def http_method
          :get
        end

        def query
          {
            ExternalId: args[:external_id],
            ExternalUserId: args[:external_user_id]
          }
        end
      end
    end
  end
end
