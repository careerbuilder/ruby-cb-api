require 'spec_helper'
require 'webmock'
Cb.configuration.dev_key = "WDHS47J77WLS2Y0N102H"
WebMock.allow_net_connect!

module Cb::Clients
  describe "GET request" do
    describe Job do
      describe '#find_by_did' do
        context 'with a real job_did' do
          let(:job_did) { 'JHQ4LP5YY6S4HLFTVM0' }
          let(:response) { Cb::Clients::Job.find_by_did(job_did) }
          
          it 'returns a valid response' do
            response.should be_a Cb::Responses::Job::Singular
            # binding.pry
          end

          it 'responds to errors' do
            response.errors.should be_a Cb::Responses::Errors
            response.errors.parsed.should be_empty
          end

          it 'responds to timings' do
            response.timing.should be_a Cb::Responses::Timing
            response.timing.elapsed.should_not be_nil
          end

          it 'returns a real job model w/ attributes' do
            response.model.should be_a Cb::Models::Job
            response.model.title.should == 'J1 Online Apply Mobile'
          end
        end
      end
    end
  end

  describe "POST request" do
    describe Application do
      describe '::create' do
        #
      end
    end
  end
end
