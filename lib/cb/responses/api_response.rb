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
require 'forwardable'

module Cb
  module Responses
    class ApiResponse
      extend Forwardable
      delegate [:timing, :errors] => :metadata
      delegate :[] => :response

      attr_reader :models, :response
      alias_method :model, :models

      def initialize(raw_response_hash)
        set_response_variable(raw_response_hash)
        @metadata = extract_metadata
        @models   = validated_models
      end

      protected

      attr_reader :metadata

      def extract_models
        fail NotImplementedError.new(__method__)
      end

      def validate_api_hash
        fail NotImplementedError.new(__method__)
      end

      def hash_containing_metadata
        fail NotImplementedError.new(__method__)
      end

      def raise_on_timing_parse_error
        true
      end

      def required_response_field(field_name, parent_hash)
        fail ArgumentError.new("field_name can't be nil!")  if field_name.nil?
        fail ArgumentError.new("parent_hash can't be nil!") if parent_hash.nil?
        fail ExpectedResponseFieldMissing.new("Response field missing '#{field_name}' for #{self.class.name}") unless parent_hash.key?(field_name)
      end

      private

      def set_response_variable(response_hash)
        should_raise = response_hash.nil? || response_hash.empty?
        fail ApiResponseError.new('Response is empty!') if should_raise
        @response = response_hash
      end

      def extract_metadata
        Metadata.new(hash_containing_metadata, raise_on_timing_parse_error) unless hash_containing_metadata.nil?
      end

      def validated_models
        validate_api_hash
        extract_models
      end
    end
  end
end
