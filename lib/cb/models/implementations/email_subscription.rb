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
    class EmailSubscription
      attr_accessor :career_resources, :product_sponsor_info, :applicant_survey_invites,
                    :job_recs, :unsubscribe_all, :djr, :resume_viewed, :application_viewed

      def initialize(args = {})
        return if args.nil?

        @career_resources             = args['CareerResources'].to_s || ''
        @product_sponsor_info         = args['ProductSponsorInfo'].to_s || ''
        @applicant_survey_invites     = args['ApplicantSurveyInvites'].to_s || ''
        @job_recs                     = args['JobRecs'].to_s || ''
        @djr                          = args['DJR'].to_s || ''
        @resume_viewed                = args['ResumeViewed'].to_s || ''
        @application_viewed           = args['ApplicationViewed'].to_s || ''
      end
    end
  end
end
