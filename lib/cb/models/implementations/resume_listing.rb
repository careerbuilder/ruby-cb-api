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
    class ResumeListing < ApiResponseModel
      attr_accessor :title, :external_id, :migration_id, :host_site, :modified_dt, :visibility

      def set_model_properties
        @title = api_response['Title']
        @external_id = api_response['ExternalID']
        @migration_id = api_response['MigrationID']
        @host_site = api_response['HostSite']
        @modified_dt = api_response['ModifiedDT']
        @visibility = api_response['Visibility']
      end

      def required_fields
        %w(Title ExternalID Visibility)
      end
    end
  end
end
