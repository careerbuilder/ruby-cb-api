# Copyright 2017 CareerBuilder, LLC
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
    class EmailSubscriptionsNew < Base
      class << self
        def get(args = {})
          cb_client.cb_get(Cb.configuration.uri_subscription_retrieve, query: query(args), headers: headers(args))
        end

        def post(args = {})
          @unsubscribe_all = args[:unsubscribe_all]
          cb_client.cb_post(Cb.configuration.uri_subscription_modify, body: body(args), headers: post_headers(args))
        end

        private

        def query(args = {})
          {
            EmailAddress: args[:email_address],
            HostSite: args[:host_site] || Cb.configuration.host_site
          }
        end

        def post_headers(args = {})
          headers(args).merge('Content-Type' => 'application/json')
        end

        def body(args = {})
          <<-eos.gsub /^\s+/, ""
             {
              subscription_id: #{args[:subscription_id]},
              email_address: #{args[:email_address]},
              hostsite: #{args[:host_site]},
              subscription_settings: 
              {
                metadata: 
                {
                  myJobs: true,
                  myActivities: true,
                  myInsights: false
                }
              },
              jobs: 
              {
                cb_job_recs: 
                {
                  email: #{validate args[:job_recs]},
                  push: false,
                  sms: false,
                  tips: false
                },
                cb_job_alerts: 
                {
                  email: #{validate args[:dynamic_job_recs]},
                  push: false,
                  sms: false,
                  tips:false,
                  email_frequency: "Daily",
                  push_frequency: "Daily",
                  sms_frequency: "Daily"

                },
                recruiter_jobs: 
                {
                  email: false,
                  push: false,
                  sms: false,
                  tips: false
                },
                talent_network_jobs: 
                {
                  email: false,
                  push: false,
                  sms: false,
                  roundup: false
                }
              },
              activities: 
              {
                application_viewed_notification: 
                {
                  email: #{validate args[:application_viewed]},
                  push: false,
                  sms: false,
                  tips: false
                },
                application_update_notification: 
                {
                  email: false,
                  push: false,
                  sms: false,
                  tips: false
                },
                resume_viewed_notification: 
                {
                  email: #{validate args[:resume_viewed]},
                  push: false,
                  sms: false,
                  tips: false
                },
                recruiter_outreach: 
                {
                  email: false,
                  push: false,
                  sms: false,
                  tips: false
                }
              },
              insights: 
              {
                salary_skills_update: 
                {
                  email: false,
                  push: false,
                  sms: false
                },
                next_job_update: 
                {
                  email: false,
                  push: false,
                  sms: false
                },
                job_seeker_newsletter: 
                {
                  email: false,
                  push: false,
                  sms: false
                },
                on_the_job_newsletter: 
                {
                  email: false,
                  push: false,
                  sms: false
                }
              },
              job_match: false,
              job_seeker_preference: false,
              my_sender_preference: false
            }
          eos
        end

        def validate(value)
          return value unless unsubscribe_all?
          false
        end
      end
    end
  end
end
