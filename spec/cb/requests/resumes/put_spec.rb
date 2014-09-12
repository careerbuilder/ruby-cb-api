require 'spec_helper'

module Cb
  describe Cb::Requests::Resumes::Put do

    context 'initialize without arguments' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::Resumes::Put.new({}) }

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_resume_put.sub(':resume_hash', nil.to_s)
          @request.http_method.should == :put
        end

        it 'should have a basic query string' do
          @request.query.should == nil
        end

        it 'should have basic headers' do
          @request.headers.should ==  { 'DeveloperKey' => Cb.configuration.dev_key,
                                        'HostSite' => Cb.configuration.host_site,
                                        'Content-Type' => 'application/json' }
        end

        it 'should have a body' do
          @request.body.should_not == nil
        end
      end

      context 'with arguments' do
        before :each do
          @resume = {
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
          @request = Cb::Requests::Resumes::Put.new(@resume)
        end

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_resume_put.sub(':resume_hash', 'resumeHash')
          @request.http_method.should == :put
        end

        it 'should have basic headers' do
          @request.headers.should ==
              {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
              }
        end

        it 'should have a basic body' do
          @request.body.should == {
              'userIdentifier'=> 'userID',
              'resumeHash'=> 'resumeHash',
              'desiredJobTitle'=> 'TrainHopper',
              'privacySetting'=> 'Public',
              'workExperience'=> [
                  {
                      'jobTitle'=> 'Hair Stylist and Colorist',
                      'companyName'=> 'Swan Beauty Parlor',
                      'employmentType'=> 'ETNS',
                      'startDate'=> '2009-09-01T00:00:00',
                      'endDate'=> '2014-08-28T00:00:00',
                      'currentlyEmployedHere'=> true
                  },
                  {
                      'jobTitle'=> 'Hair Stylist',
                      'companyName'=> 'Sweet Dreams Beauty Salon',
                      'employmentType'=> 'ETNS',
                      'startDate'=> '2008-06-01T00:00:00',
                      'endDate'=> '2009-09-01T00:00:00',
                      'currentlyEmployedHere'=> false
                  },
                  {
                      'jobTitle'=> 'Assistant/Receptionist',
                      'companyName'=> 'Oak Park Beauty',
                      'employmentType'=> 'ETNS',
                      'startDate'=> '2006-09-01T00:00:00',
                      'endDate'=> '2008-06-01T00:00:00',
                      'currentlyEmployedHere'=> false
                  },
                  {
                      'jobTitle'=> 'Lead role',
                      'companyName'=> 'The Sound of Music',
                      'employmentType'=> 'ETNS',
                      'startDate'=> '2007-03-01T00:00:00',
                      'endDate'=> '2007-05-31T00:00:00',
                      'currentlyEmployedHere'=> false
                  },
                  {
                      'jobTitle'=> 'magic place',
                      'companyName'=> 'Child Cancer Research',
                      'employmentType'=> 'ETNS',
                      'startDate'=> '2006-03-01T00:00:00',
                      'endDate'=> '2006-05-31T00:00:00',
                      'currentlyEmployedHere'=> false
                  }
              ],
              'salaryInformation'=> {
                  'mostRecentPayAmount'=> 0,
                  'perHourOrPerYear'=> 'Hour',
                  'currencyCode'=> 'USD',
                  'jobTitle'=> 'magic place',
                  'annualBonus'=> 0,
                  'annualCommission'=> 0,
              },
              'educations'=> [
                  {
                      'schoolName'=> 'Hair dids and magic fluits academy.',
                      'major'=> 'Gettin Hair did',
                      'degreeCode'=> 'CE3',
                      'graduationDate'=> '2008-05-01T00:00:00'
                  },
                  {
                      'schoolName'=> 'Oak Park River Forest High School',
                      'major'=> 'Not Applicable',
                      'degreeCode'=> 'CE31',
                      'graduationDate'=> '2007-05-01T00:00:00'
                  }
              ],
              'skillsAndQualifications'=> {
                  'accreditationsAndCertifications'=> '',
                  'languagesSpoken'=> ['english', 'spanish'],
                  'hasManagementExperience'=> false,
                  'sizeOfTeamManaged'=> 0
              },
              'relocations'=> [
                  {
                      'city'=> 'atlanta',
                      'adminArea'=> '',
                      'countryCode'=> 'us'
                  },
                  {
                      'city'=> 'winter',
                      'adminArea'=> '',
                      'countryCode'=> 'us'
                  }
              ],
              'governmentAndMilitary'=> {
                  'hasSecurityClearance'=> false,
                  'militaryExperience'=> ''
              }
            }.to_json
        end
      end
    end

  end
end
