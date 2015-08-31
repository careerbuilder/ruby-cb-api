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
  module Utils
    class ResponseArrayExtractor
      def self.extract(response_hash, key, singular_key = nil)
        new(response_hash, key, singular_key).extract
      end

      def initialize(response_hash, key, singular_key)
        @response_hash = response_hash
        @key = key
        @singular_key = singular_key || key[0..key.length - 2]
      end

      def extract
        if response_has_collection?
          extract_array_from_collection
        elsif response_has_array?
          build_array_from_delimited_values
        else
          []
        end
      end

      private

      def response_has_array?
        !@response_hash[@key].nil? && @response_hash[@key].class != Hash
      end

      def response_has_collection?
        !@response_hash[@key].nil? && !@response_hash[@key][@singular_key].nil?
      end

      def build_array_from_delimited_values
        @response_hash[@key].split(',')
      end

      def extract_array_from_collection
        if @response_hash[@key][@singular_key].is_a?(Array)
          @response_hash[@key][@singular_key]
        else
          [@response_hash[@key][@singular_key]]
        end
      end
    end
  end
end
