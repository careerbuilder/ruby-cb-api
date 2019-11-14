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
require_relative '../base'

module Cb
  module Requests
    module EmailSubscriptionsNew
      class Modify < Base
        def endpoint_uri
          Cb.configuration.uri_subscription_modify
        end

        def http_method
          :post
        end

        def body
          <<eos
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

        private

        def validate(value)
          case value.to_s
          when 'true','TRUE', 'True' , '1'
            return true
          else
            return false
          end
        end
      end
    end
  end
end
