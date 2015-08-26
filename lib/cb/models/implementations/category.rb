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
    class Category
      attr_accessor :code, :name, :language
      def initialize(args = {})
        @code					= args['Code'] || ''
        @name					= args['Name']['#text'] || ''
        @language     = args['Name']['@language'] || ''
      end

      def CategoryName
        @name unless @name.nil?
      end

      def CategoryCode
        @code unless @code.nil?
      end

      def CategoryLanguage
        @language unless @language.nil?
      end
    end
  end
end
