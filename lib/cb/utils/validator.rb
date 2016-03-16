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
require 'nori'

module Cb
  module ResponseValidator
    class << self
      def validate(response)
        raise_response_code_errors(response)
        process_response_body(response)
      end

      private

      def raise_response_code_errors(response)
        code = response.code rescue nil
        fail Cb::ServiceUnavailableError if code == 503 || simulate_auth_outage?
        fail Cb::UnauthorizedError if code == 401
      end

      def simulate_auth_outage?
        ENV['SIMULATE_AUTH_OUTAGE'].to_s.downcase == 'true'
      end

      def process_response_body(response)
        body = response.response.body rescue nil
        return {} unless body

        return {} if body.include?('<!DOCTYPE html') if response.code != 200

        try_parse_json(body) || try_parse_xml(body) || {}
      end

      def try_parse_json(body)
        JSON.parse(body)
      rescue JSON::ParserError
        nil
      end

      def try_parse_xml(body)
        MultiXml.parse(body, KeepRoot: true)
      rescue MultiXml::ParseError
        nil
      end
    end
  end
end
