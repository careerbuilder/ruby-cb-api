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
  module Models
    class WorkStatus
      attr_accessor :key, :translations

      def initialize(args = {})
        return if args.nil?
        @key          = args['Key'] || ''
        @translations = [args['Description']].flatten.map { |translation| Translation.new translation }
      end

      class Translation
        attr_accessor :language, :value

        def initialize(args = {})
          return if args.nil?
          @language = args['Language'] || ''
          @value    = args['Value'] || ''
        end
      end
    end
  end
end
