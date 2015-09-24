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

module  Cb
  module Requests
    module Job
      class Report < Base

        def endpoint_uri
          Cb.configuration.uri_report_job
        end

        def http_method
          :post
        end

        def body
          <<-eos
          <Request>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
            <JobDID>#{args[:job_id]}</JobDID>
            <UserID>#{args[:user_id]}</UserID>
            <ReportType>#{args[:report_type]}</ReportType>
            <Comments>#{args[:comments]}</Comments>
          </Request>
          eos
        end

      end
    end
  end
end