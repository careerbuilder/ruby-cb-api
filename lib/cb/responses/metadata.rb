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
module Cb
  module Responses
    class Metadata
      attr_reader :errors, :timing

      def initialize(raw_response_hash, raise_on_timing_missing = true)
        @response     = raw_response_hash
        @should_raise = raise_on_timing_missing
        @errors       = parsed_errors
        @timing       = parsed_timing_info
      end

      private

      attr_reader :response, :should_raise

      def parsed_errors
        Errors.new(response)
      end

      def parsed_timing_info
        Timing.new(response, should_raise)
      end
    end
  end
end
