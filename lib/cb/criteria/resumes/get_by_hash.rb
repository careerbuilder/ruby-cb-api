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
  module Criteria
    module Resumes
      class GetByHash
        extend Cb::Utils::FluidAttributes

        fluid_attr_accessor :resume_hash, :external_user_id

        def initialize(args = {})
          @resume_hash        = args[:resumeHash] || ''
          @external_user_id        = args[:externalUserID] || ''
        end

        def to_hash
          { resume_hash: @resume_hash, external_user_id: @external_user_id }
        end

        alias_method :to_h, :to_hash
      end
    end
  end
end
