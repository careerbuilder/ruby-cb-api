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
    class CoverLetters < Base
      class << self
        def get(args={})
          uri = Cb.configuration.uri_cover_letters
          uri += "/#{ args[:id] }" if args[:id]
          cb_client.cb_get(uri, headers: headers(**args))
        end

        def create(args={})
          cb_client.cb_put(Cb.configuration.uri_cover_letters,
                           body: body(args),
                           headers: headers(**args))
        end

        def delete(args={})
          cb_client.cb_delete(uri_with_id(args), body: body(args), headers: headers(**args))
        end

        def update(args={})
          cb_client.cb_post(uri_with_id(args), body: body(args), headers: headers(**args))
        end

        private

        def uri_with_id(args)
          "#{ Cb.configuration.uri_cover_letters }/#{ args[:id] }"
        end

        def body(args)
          body = Hash.new
          body[:id] = args[:id] if args[:id]
          body[:text] = args[:text] if args[:text]
          body[:name] = args[:name] if args[:name]
          body.to_json
        end
      end
    end
  end
end
