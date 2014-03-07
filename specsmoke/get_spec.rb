require 'spec_helper'
require 'webmock'
require 'dotenv'
Dotenv.load

Cb.configuration.dev_key = ENV['DEVELOPER_KEY']
WebMock.allow_net_connect!

module Cb::Clients
  describe "GET request" do
    describe Job do
      describe '#find_by_did' do
        context 'with a real job_did' do
          before(:all) do
            job_did = 'JHQ4LP5YY6S4HLFTVM0'
            @response = Cb::Clients::Job.find_by_did(job_did)
          end
          
          it 'returns a valid response' do
            @response.should be_a Cb::Responses::Job::Singular
          end

          it 'responds to errors' do
            @response.errors.should be_a Cb::Responses::Errors
            @response.errors.parsed.should be_empty
          end

          it 'responds to timings' do
            @response.timing.should be_a Cb::Responses::Timing
            @response.timing.elapsed.should_not be_nil
          end

          it 'returns a real job model w/ attributes' do
            @response.model.should be_a Cb::Models::Job
            @response.model.title.should == 'J1 Online Apply Mobile'
          end
        end
      end
    end
  end

  describe "POST request" do
    describe Application do
      describe '::create' do
        before(:all) do
          job_did = 'JHQ4LP5YY6S4HLFTVM0'
          resume = Cb::Criteria::Application::Resume.new
            .external_resume_id('XRHN1QJ6V0DZPZHBPZNM')
            .resume_file_name('my resume')
            .resume_data(1010101010101)
            .resume_extension('pdf')
            .resume_title('Nurse')
          cover_letter = Cb::Criteria::Application::CoverLetter.new
          resume_responses = []
          criteria = Cb::Criteria::Application::Create.new
            .job_did(job_did)
            .is_submitted(false)
            .external_user_id('XRHL5WB644K882Z72Y7B')
            .vid('hamburger_avalanche')
            .bid('bid_123')
            .sid('sid_123')
            .site_id('site_123')
            .ipath_id('ipath_123')
            .tn_did('tn_123')
            .resume(resume)
            .cover_letter(cover_letter)
            .responses(resume_responses)
          @response = Cb::Clients::Application.create(criteria)
        end

        it 'returns a valid response' do
          @response.should be_a Cb::Responses::Application
        end

        it 'responds to errors' do
          @response.errors.should be_a Cb::Responses::Errors
          @response.errors.parsed.should be_empty
        end

        it 'responds to timings' do
binding.pry
          @response.timing.should be_a Cb::Responses::Timing
          @response.timing.elapsed.should_not be_nil
        end

        it 'returns a real job model w/ attributes' do
          # binding.pry
          @response.model[0].should be_a Cb::Models::Application
          @response.model.title.should == 'J1 Online Apply Mobile'
        end
      end
    end
  end
end
