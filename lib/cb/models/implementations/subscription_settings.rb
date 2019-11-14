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
      class SubscriptionSettings
        attr_accessor :metadata

        def initialize(args = {})
          return if args.nil?

          @metadata          = Metadata.new(args['Metadata'])
        end
      end

      class Metadata
        attr_accessor :myJobs, :myActivities, :myInsights

        def initialize(args = {})
          return if args.nil?

          @myJobs                = args['myJobs'].to_s || ''
          @myActivities          = args['myActivities'].to_s || ''
          @myInsights            = args['myInsights'].to_s || ''
        end
      end
    end
  end
end
