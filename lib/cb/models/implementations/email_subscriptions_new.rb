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
require_relative 'jobs/job'
require_relative 'insights/insight'
require_relative 'activities/activity'

module Cb
  module Models
    class EmailSubscriptionsNew
      attr_accessor :subscription_id, :email_address, :hostsite, :subscription_settings, :jobs, :activities,
                    :insights, :job_match, :job_seeker_preference, :my_sender_preference, :sysinserteddt, :sysmodifieddt

      def initialize(args = {})
        return if args.nil?

        @subscription_id          = args['subscription_id'].to_i || 0
        @email_address            = args['email_address'].to_s || ''
        @hostsite                 = args['hostsite'].to_s || 0
        @subscription_settings    = SubscriptionSettings.new(args['subscription_settings'])
        @jobs                     = Jobs::Job.new(args['jobs'])
        @activities               = Activities::Activity.new(args['activities'])
        @insights                 = Insights::Insight.new(args['insights'])
        @job_match                = args['job_match'].to_s || ''
        @job_seeker_preference    = args['job_seeker_preference'].to_s || ''
        @my_sender_preference     = args['my_sender_preference'].to_s || ''

      end
    end
  end
end
