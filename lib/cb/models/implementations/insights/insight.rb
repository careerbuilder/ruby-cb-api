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
    class Insights
      class Insight
        attr_accessor :next_job_update, :job_seeker_newsletter, :on_the_job_newsletter, :salary_skills

        def initialize(args = {})
          return if args.nil?

          @next_job_update                   = Insights::NextJobUpdate.new(args['NextJobUpdate'])
          @job_seeker_newsletter             = Insights::JobSeekerNewsletter.new(args['JobSeekerNewsletter'])
          @on_the_job_newsletter             = Insights::OnTheJobNewsletter.new(args['OnTheJobNewsletter'])
          @salary_skills                     = Insights::SalarySkills.new(args['SalarySkills'])
        end
      end
    end
  end
end
