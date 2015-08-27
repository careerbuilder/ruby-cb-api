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
  module Responses
    class Errors
      attr_reader :parsed

      def initialize(raw_response_hash, raise_on_error = true)
        @response     = raw_response_hash
        @should_raise = raise_on_error
        @parsed       = parsed_errors
      end

      private

      attr_reader :response, :should_raise

      def parsed_errors
        return [] unless response.respond_to?(:map)
        errors = response.map { |key, value| parsed_error(key, value) }.flatten
        fail ApiResponseError.new(errors.join(',')) if errors.any? && should_raise
        errors
      end

      def parsed_error(key, value)
        if hashy_errors?(key, value)
          value.values
        elsif error_array?(key, value)
          value
        else
          []
        end
      end

      def hashy_errors?(key, value)
        key.downcase == 'errors' && value.is_a?(Hash)
      end

      def error_array?(key, value)
        (key.downcase == 'error' || key.downcase == 'errors') && value.is_a?(Array)
      end

      def method_missing(method, *args, &block)
        parsed.send(method, *args, &block)
      end
    end
  end
end
