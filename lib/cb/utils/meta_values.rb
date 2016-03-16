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
  module Utils
    class MetaValues
      # This class will be dynamically constructed at run time.
      # I don't want values that don't make sense to the API call you made to be accessible
      # I'm not dynamically creating the class because we may want to add functionality at some point

      # This class, with its dynamically created attr_accr's will be dynamically appended to api
      # entities, like job and company. It will contain things like errors, time elapsed, and
      # any other meta values that the API may return.

      # The mapping for allowed values, and what they translate to on this object live in Cb::utils::Api
    end
  end
end
