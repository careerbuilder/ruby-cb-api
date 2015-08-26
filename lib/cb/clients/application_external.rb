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
require 'json'

module Cb
  module Clients
    class ApplicationExternal
      def self.submit_app(app)
        fail Cb::IncomingParamIsWrongTypeException unless app.is_a?(Cb::Models::ApplicationExternal)

        my_api = Cb::Utils::Api.instance
        xml_hash = my_api.cb_post(Cb.configuration.uri_application_external, body: app.to_xml)

        if xml_hash.key? 'ApplyUrl'
          app.apply_url = xml_hash['ApplyUrl']
        else
          app.apply_url = ''
        end

        my_api.append_api_responses(app, xml_hash)
      end
    end
  end
end
