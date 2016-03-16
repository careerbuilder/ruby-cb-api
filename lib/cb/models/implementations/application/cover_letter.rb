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
    class Application < ApiResponseModel
      class CoverLetter < ApiResponseModel
        attr_accessor :cover_letter_id, :cover_letter_text, :cover_letter_title

        protected

        def required_fields
          []
        end

        def set_model_properties
          @cover_letter_id = api_response['CoverLetterID']
          @cover_letter_text = api_response['CoverLetterText']
          @cover_letter_title = api_response['CoverLetterTitle']
        end
      end
    end
  end
end
