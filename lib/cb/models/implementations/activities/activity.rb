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
    class Activities
      class Activity
        attr_accessor :application_viewed_notification, :application_update_notification, :resume_viewed_notification, :recruiter_outreach

        def initialize(args = {})
          return if args.nil?

          @application_viewed_notification          = Activities::ApplicationViewedNotification.new(args['ApplicationViewedNotification'])
          @application_update_notification          = Activities::ApplicationUpdateNotification.new(args['ApplicationUpdateNotification'])
          @resume_viewed_notification               = Activities::ResumeViewedNotification.new(args['ResumeViewedNotification'])
          @recruiter_outreach                       = Activities::RecruiterOutreach.new(args['RecruiterOutreach'])
        end
      end
    end
  end
end
