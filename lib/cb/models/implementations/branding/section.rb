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
    module Branding
      class Section
        attr_accessor :type, :section_1, :section_2, :section_3, :description, :requirements, :snapshot

        def initialize(type, args = {})
          @type = type
          @section_1 = args['Section1'] || ''
          @section_2 = args['Section2'] || ''
          @section_3 = args['Section3'] || ''
          @description = args['Description'] || ''
          @requirements = args['Requirements'] || ''
          @snapshot = args['Snapshot'] || ''
        end
      end
    end
  end
end
