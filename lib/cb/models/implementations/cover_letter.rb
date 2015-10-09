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
    class CoverLetter
      attr_reader :id, :name, :text, :created, :modified

      def initialize(api_cover_letter)
        @id = api_cover_letter['CoverLetterDID'] || api_cover_letter['ExternalId']
        @name = api_cover_letter['CoverLetterName'] || api_cover_letter['Name']
        @text = api_cover_letter['CoverLetterText'] || api_cover_letter['Text']
        @created = api_cover_letter['CreatedDate'] || api_cover_letter['CreatedDT']
        @modified = api_cover_letter['ModifiedDate'] || api_cover_letter['ModifiedDT']
      end
    end
  end
end
