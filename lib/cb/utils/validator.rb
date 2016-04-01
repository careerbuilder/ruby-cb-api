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
        fail_with_error_details(response, Cb::ServiceUnavailableError) if code == 503 || simulate_auth_outage?
        fail_with_error_details(response, Cb::UnauthorizedError) if code == 401 || code == 403
        fail_with_error_details(response, Cb::DocumentNotFoundError) if code == 404
        fail_with_error_details(response, Cb::BadRequestError) if code && code >= 400 && code < 500
        fail_with_error_details(response, Cb::ServerError) if code && code >= 500
      end

      def fail_with_error_details(response, error_type)
        error = error_type.new
        error.code = response.code rescue nil
        error.raw_response = response
        error.response = process_response_body(response)
        fail error
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
