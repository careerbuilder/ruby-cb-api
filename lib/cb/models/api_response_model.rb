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
  module Models
    class ApiResponseModel
      attr_accessor :api_response

      def initialize(response = {})
        @api_response = response
        validate_api_response
        set_model_properties
      end

      protected

      def required_fields
        # return an array of hash keys to check for in your api hash
        fail NotImplementedError.new(__method__)
      end

      def set_model_properties
        # do whatever work you need to do to set up the attributes on your model
        fail NotImplementedError.new(__method__)
      end

      private

      def validate_api_response
        missing_fields  = required_fields.map { |field| field unless @api_response.key?(field) }.compact
        fail ExpectedResponseFieldMissing.new(missing_fields.join(' ')) unless missing_fields.empty?
      end
    end
  end
end
