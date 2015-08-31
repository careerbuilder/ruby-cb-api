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
    class Industry < ApiResponseModel
      attr_accessor :code, :name

      def initialize(args = {})
        @api_response = args
        @code         = args['Code'] || ''
        @name         = args['Name']['#text'] || ''
        @language     = args['Name']['@language'] || ''

        validate_api_response
      end

      protected

      def required_fields
        %w(Code Name)
      end
    end
  end
end
