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
      class Update < Base
        def endpoint_uri
          Cb.configuration.uri_cover_letter_update
        end

        def http_method
          :post
        end

        def body
          <<-eos
            <Request>
              <DeveloperKey>#{ Cb.configuration.dev_key }</DeveloperKey>
              <ExternalID>#{ args[:external_id] }</ExternalID>
              <ExternalUserID>#{ args[:external_user_id] }</ExternalUserID>
              <CoverLetterTitle>#{ args[:cover_letter_title] }</CoverLetterTitle>
              <Text>#{ args[:text] }</Text>
              <Test>#{ args[:test] || false }</Test>
            </Request>
          eos
        end
      end
    end
  end
end
