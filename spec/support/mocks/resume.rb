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
module Mocks
  class Resume
    class << self
      def snake_case_resume_hash
        {
          user_identifier: 'userID',
          resume_hash: 'resumeHash',
          desired_job_title: 'TrainHopper',
          privacy_setting: 'Public',
          work_experience:
            [
              {
                job_title: 'Hair Stylist and Colorist',
                company_name: 'Swan Beauty Parlor',
                employment_type: 'ETNS',
                start_date: '2009-09-01T00:00:00',
                end_date: '2014-08-28T00:00:00',
                currently_employed_here: true,
                work_activities: 'blarg',
                id: 'workexperienceID'
              },
              {
                job_title: 'Hair Stylist',
                company_name: 'Sweet Dreams Beauty Salon',
                employment_type: 'ETNS',
                start_date: '2008-06-01T00:00:00',
                end_date: '2009-09-01T00:00:00',
                currently_employed_here: false,
                work_activities: 'blarg',
                id: 'workexperienceID'
              },
              {
                job_title: 'Assistant/Receptionist',
                company_name: 'Oak Park Beauty',
                employment_type: 'ETNS',
                start_date: '2006-09-01T00:00:00',
                end_date: '2008-06-01T00:00:00',
                currently_employed_here: false,
                work_activities: 'blarg',
                id: 'workexperienceID'
              },
              {
                job_title: 'Lead role',
                company_name: 'The Sound of Music',
                employment_type: 'ETNS',
                start_date: '2007-03-01T00:00:00',
                end_date: '2007-05-31T00:00:00',
                currently_employed_here: false,
                work_activities: 'blarg',
                id: 'workexperienceID'
              },
              {
                job_title: 'magic place',
                company_name: 'Child Cancer Research',
                employment_type: 'ETNS',
                start_date: '2006-03-01T00:00:00',
                end_date: '2006-05-31T00:00:00',
                currently_employed_here: false,
                work_activities: 'blarg',
                id: 'workexperienceID'
              }
            ],
          salary_information:
            {
              most_recent_pay_amount: 0,
              per_hour_or_per_year: 'Hour',
              currency_code: 'USD',
              work_experience_id: 'workexperienceID',
              annual_bonus: 0,
              annual_commission: 0
            },
          educations:
            [
              {
                school_name: 'Hair dids and magic fluits academy.',
                major_or_program: 'Gettin Hair did',
                degree: 'CE3',
                graduation_date: '2008-05-01T00:00:00'
              },
              {
                school_name: 'Oak Park River Forest High School',
                major_or_program: 'Not Applicable',
                degree: 'CE31',
                graduation_date: '2007-05-01T00:00:00'
              }
            ],
          skills_and_qualifications:
            {
              accreditations_and_certifications: '',
              languages_spoken: %w(english spanish),
              has_management_experience: false,
              size_of_team_managed: 0
            },
          relocations:
            [
              {
                city: 'atlanta',
                admin_area: '',
                country_code: 'us'
              },
              {
                city: 'winter',
                admin_area: '',
                country_code: 'us'
              }
            ],
          government_and_military:
            {
              has_security_clearance: false,
              military_experience: ''
            },
          resumeFileData: nil,
          resumeFileName: nil,
          replaceEducationAndExperience: false
        }
      end

      def camel_case_resume_hash
        {
          'userIdentifier' => 'userID',
          'resumeHash' => 'resumeHash',
          'desiredJobTitle' => 'TrainHopper',
          'privacySetting' => 'Public',
          'workExperience' =>             [
            {
              'jobTitle' => 'Hair Stylist and Colorist',
              'companyName' => 'Swan Beauty Parlor',
              'employmentType' => 'ETNS',
              'startDate' => '2009-09-01T00:00:00',
              'endDate' => '2014-08-28T00:00:00',
              'currentlyEmployedHere' => true,
              'experienceDetail' => 'blarg',
              'id' => 'workexperienceID'
            },
            {
              'jobTitle' => 'Hair Stylist',
              'companyName' => 'Sweet Dreams Beauty Salon',
              'employmentType' => 'ETNS',
              'startDate' => '2008-06-01T00:00:00',
              'endDate' => '2009-09-01T00:00:00',
              'currentlyEmployedHere' => false,
              'experienceDetail' => 'blarg',
              'id' => 'workexperienceID'
            },
            {
              'jobTitle' => 'Assistant/Receptionist',
              'companyName' => 'Oak Park Beauty',
              'employmentType' => 'ETNS',
              'startDate' => '2006-09-01T00:00:00',
              'endDate' => '2008-06-01T00:00:00',
              'currentlyEmployedHere' => false,
              'experienceDetail' => 'blarg',
              'id' => 'workexperienceID'
            },
            {
              'jobTitle' => 'Lead role',
              'companyName' => 'The Sound of Music',
              'employmentType' => 'ETNS',
              'startDate' => '2007-03-01T00:00:00',
              'endDate' => '2007-05-31T00:00:00',
              'currentlyEmployedHere' => false,
              'experienceDetail' => 'blarg',
              'id' => 'workexperienceID'
            },
            {
              'jobTitle' => 'magic place',
              'companyName' => 'Child Cancer Research',
              'employmentType' => 'ETNS',
              'startDate' => '2006-03-01T00:00:00',
              'endDate' => '2006-05-31T00:00:00',
              'currentlyEmployedHere' => false,
              'experienceDetail' => 'blarg',
              'id' => 'workexperienceID'
            }
          ],
          'salaryInformation' =>             {
            'mostRecentPayAmount' => 0,
            'perHourOrPerYear' => 'Hour',
            'currencyCode' => 'USD',
            'workExperienceId' => 'workexperienceID',
            'annualBonus' => 0,
            'annualCommission' => 0

          },
          'educations' =>             [
            {
              'schoolName' => 'Hair dids and magic fluits academy.',
              'majorOrProgram' => 'Gettin Hair did',
              'degree' => 'CE3',
              'graduationDate' => '2008-05-01T00:00:00'
            },
            {
              'schoolName' => 'Oak Park River Forest High School',
              'majorOrProgram' => 'Not Applicable',
              'degree' => 'CE31',
              'graduationDate' => '2007-05-01T00:00:00'
            }
          ],
          'skillsAndQualifications' =>             {
            'accreditationsAndCertifications' => '',
            'languagesSpoken' => %w(english spanish),
            'hasManagementExperience' => false,
            'sizeOfTeamManaged' => 0
          },
          'relocations' =>             [
            {
              'city' => 'atlanta',
              'adminArea' => '',
              'countryCode' => 'us'
            },
            {
              'city' => 'winter',
              'adminArea' => '',
              'countryCode' => 'us'
            }
          ],
          'governmentAndMilitary' =>             {
            'hasSecurityClearance' => false,
            'militaryExperience' => ''
          },
          'resumeFileData' => nil,
          'resumeFileName' => nil,
          'replaceEducationAndExperience' => false
        }
      end
    end
  end
end
