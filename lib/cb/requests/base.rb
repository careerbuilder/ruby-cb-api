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
  module Requests
    class Base
      attr_reader :args

      def initialize(argument_hash)
        fail ArgumentError.new("#{argument_hash.class} is not a Hash") unless argument_hash.is_a?(Hash)
        @args = argument_hash
      end

      def base_uri
        Cb.configuration.base_uri
      end

      def endpoint_uri
        fail NotImplementedError.new __method__
      end

      def http_method
        fail NotImplementedError.new __method__
      end

      def query
        nil
      end

      def headers
        nil
      end

      def body
        nil
      end

      private

      def test?
        (args[:test] || Cb.configuration.test_resources).to_s
      end
    end
  end
end
