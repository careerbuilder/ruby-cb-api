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
  module Responses
    module User
      class TemporaryPassword < ApiResponse
        # there's really no response model here, so let's just
        # pass the new password along in a way that makes sense.
        alias_method :temp_password, :model

        protected

        def validate_api_hash
          required_response_field(password_node, response)
        end

        def extract_models
          response[password_node]
        end

        def hash_containing_metadata
          response
        end

        def raise_on_timing_parse_error
          false
        end

        private

        def password_node
          'TemporaryPassword'
        end
      end
    end
  end
end
