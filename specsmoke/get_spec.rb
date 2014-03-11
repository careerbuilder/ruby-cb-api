require 'spec_helper'
require 'webmock'
require 'dotenv'

Dotenv.load
WebMock.allow_net_connect!

Cb.configuration.dev_key = ENV['DEVELOPER_KEY']
Cb.configuration.debug_api = false

module Cb::Clients
  describe "GET requests" do
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
end
