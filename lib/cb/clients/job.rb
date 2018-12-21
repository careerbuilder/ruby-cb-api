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
require_relative 'base'
module Cb
  module Clients
    class Job < Base
      class << self
        def get(oauth_token, args = {}, use_v3_endpoint = false)
          response = cb_client.cb_get(uri_get(args[:Did], use_v3_endpoint), headers: headers(oauth_token), query: args)
          not_found_check(response)
          response
        end

        def report(args = {})
          cb_client.cb_post(Cb.configuration.uri_report_job, body: report_body(args))
        end

        private

        def uri_get (job_id, use_v3_endpoint)
          if use_v3_endpoint
            Cb.configuration.uri_job_find_v3
          else
            "#{Cb.configuration.uri_job_find}/#{job_id}"
          end
        end

        def headers(oauth_token)
          {
             'Accept' => 'application/json',
             'Authorization' => "Bearer #{ oauth_token }",
             'Content-Type' => 'application/json'
          }
        end

        def not_found_check(response)
          return if response.nil?
          errors = Cb::Responses::Errors.new(response['ResponseJob'], false).parsed.join
          raise Cb::DocumentNotFoundError, errors if errors.downcase.include? 'job was not found'
        end

        def report_body(args = {})
          <<-eos.gsub /^\s+/, ""
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
