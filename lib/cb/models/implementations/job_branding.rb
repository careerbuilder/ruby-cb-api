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
    class JobBranding
      attr_accessor :name, :media, :sections, :styles, :widgets, :id, :account_id, :type, :errors, :show_widgets, :company_description

      def initialize(args = {})
        @name = args['Name'] || ''
        @id = args['Id'] || ''
        @account_id = args['AccountId'] || ''
        @type = args['Type'] || ''
        @media = Branding::Media.new args['Media']
        @styles = Branding::Style.new args['Styles']
        @errors = args['Errors'] || ''
        @company_description = args['CompanyDescription'] || ''
        @sections = []
        @widgets = []

        args['Sections'].each do |type, sections|
          @sections << Branding::Section.new(type, sections) unless sections.nil?
        end

        args['Widgets'].each do |type, url|
          if type == 'ShowWidgets'
            @show_widgets = url == 'true'
          else
            @widgets << Branding::Widget.new(type, url) unless url.nil?
          end
        end
      end
    end
  end
end
