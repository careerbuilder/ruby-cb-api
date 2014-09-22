require 'spec_helper'
require 'support/mocks/resume'

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
          @resume = Mocks::Resume.complete_resume_hash
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
                  'majorOrProgram'=> 'Gettin Hair did',
                  'degreeCode'=> 'CE3',
                  'graduationDate'=> '2008-05-01T00:00:00'
                  },
                  {
                  'schoolName'=> 'Oak Park River Forest High School',
                  'majorOrProgram'=> 'Not Applicable',
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
