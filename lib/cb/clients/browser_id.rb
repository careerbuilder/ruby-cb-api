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
require_relative 'base'
module Cb
  module Clients
    class BrowserID < Base
      class << self
        # https://careerbuilder.readme.io/docs/consumerbrowser-id
        def get(args={})
          cb_client.cb_get(Cb.configuration.uri_browser_id, headers: headers(**args))
        end
      end
    end
  end
end
