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
          @resume_json = JSON.parse(File.read('spec/support/response_stubs/resume_get.json'))
          @resume = {
            user_identifier: 'XRJ15B864VKHYTG9544N',
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
              languages_spoken: [ ],
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
          @request.headers.should == {
                                     'DeveloperKey' => Cb.configuration.dev_key,
                                     'HostSite' => Cb.configuration.host_site,
                                     'Content-Type' => 'application/json'
                                     }
        end

        it 'should have a basic body' do
          @request.body.should == @resume_json
        end
      end
    end

  end
end
