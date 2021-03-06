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
require 'nokogiri'

module Cb
  module Criteria
    module User
      class Delete
        attr_accessor :external_id, :password, :test

        def initialize(args = {})
          @external_id                  = args[:external_id] || ''
          @password                     = args[:password] || ''
          @test                         = args[:test] || 'false'
        end

        def to_xml
          Nokogiri::XML::Builder.new do |xml|
            xml.Request do
              xml.DeveloperKey Cb.configuration.dev_key
              xml.Password password
              xml.ExternalID external_id
              xml.Test test # ruby has a builtin called test, confusion occurs :(
            end
          end.to_xml
        end
      end
    end
  end
end
