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
    class Timing
      attr_reader :response_sent, :elapsed

      def initialize(response, raise_on_parse_fail = true)
        @response = response
        @should_raise_on_parse_fail = raise_on_parse_fail
        post_initialize
      end

      private

      attr_reader :response, :should_raise_on_parse_fail

      def post_initialize
        raise_on_empty_timing_info
        @response_sent = parsed_response_sent
        @elapsed       = parsed_time_elapsed
      end

      def raise_on_empty_timing_info
        should_raise = (response.nil? || !response.respond_to?(:[])) && should_raise_on_parse_fail
        fail ExpectedResponseFieldMissing.new('Missing/malformed timing info!') if should_raise
      end

      def parsed_response_sent
        DateTime.parse(response['TimeResponseSent']) rescue nil
      end

      def parsed_time_elapsed
        elapsed_node_parsable? ? response[elapsed_node].to_f : nil
      end

      def elapsed_node_parsable?
        response.include?(elapsed_node) &&
          response[elapsed_node].respond_to?(:to_f) &&
          timing_parses_to_nonzero?
      end

      def timing_parses_to_nonzero?
        response[elapsed_node].to_f != 0.0
      end

      def elapsed_node
        'TimeElapsed'
      end
    end
  end
end
