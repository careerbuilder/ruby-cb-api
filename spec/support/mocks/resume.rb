module Mocks
  class Resume
    class << self

      def complete_resume_hash
        {
          user_identifier: 'userID',
          resume_hash: 'resumeHash',
          desired_job_title: 'TrainHopper',
          privacy_setting: 'Public',
          work_experience: [
              {
                  job_title: 'Hair Stylist and Colorist',
                  company_name: 'Swan Beauty Parlor',
                  employment_type: 'ETNS',
                  start_date: '2009-09-01T00:00:00',
                  end_date: '2014-08-28T00:00:00',
                  currently_employed_here: true
              },
              {
                  job_title: 'Hair Stylist',
                  company_name: 'Sweet Dreams Beauty Salon',
                  employment_type: 'ETNS',
                  start_date: '2008-06-01T00:00:00',
                  end_date: '2009-09-01T00:00:00',
                  currently_employed_here: false
              },
              {
                  job_title: 'Assistant/Receptionist',
                  company_name: 'Oak Park Beauty',
                  employment_type: 'ETNS',
                  start_date: '2006-09-01T00:00:00',
                  end_date: '2008-06-01T00:00:00',
                  currently_employed_here: false
              },
              {
                  job_title: 'Lead role',
                  company_name: 'The Sound of Music',
                  employment_type: 'ETNS',
                  start_date: '2007-03-01T00:00:00',
                  end_date: '2007-05-31T00:00:00',
                  currently_employed_here: false
              },
              {
                  job_title: 'magic place',
                  company_name: 'Child Cancer Research',
                  employment_type: 'ETNS',
                  start_date: '2006-03-01T00:00:00',
                  end_date: '2006-05-31T00:00:00',
                  currently_employed_here: false
              }
          ],
          salary_information: {
              most_recent_pay_amount: 0,
              per_hour_or_per_year: 'Hour',
              currency_code: 'USD',
              annual_bonus: 0,
              annual_commission: 0,
              job_title: 'magic place'
          },
          educations: [
              {
                  school_name: 'Hair dids and magic fluits academy.',
                  major: 'Gettin Hair did',
                  degree_code: 'CE3',
                  graduation_date: '2008-05-01T00:00:00'
              },
              {
                  school_name: 'Oak Park River Forest High School',
                  major: 'Not Applicable',
                  degree_code: 'CE31',
                  graduation_date: '2007-05-01T00:00:00'
              }
          ],
          skills_and_qualifications: {
              accreditations_and_certifications: '',
              languages_spoken: [ 'english', 'spanish'],
              has_management_experience: false,
              size_of_team_managed: 0
          },
          relocations: [
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
          government_and_military: {
              has_security_clearance: false,
              military_experience: ''
          }
        }
      end

    end
  end
end