require 'spec_helper'


module Cb
  describe Cb::ApplicationExternalApi do

    context '#submit_app' do
      before :each do
        @app = Cb::CbApplicationExternal.new({:job_did => 'bogus-did', :site_id => 'bogus', :email => 'bogus',
                                              :ipath => 'bogus-ipath', :apply_url => 'jobs.baconparadise.com'})
      end

      def stub_app_submission_to_return(response_content)
        stub_request(:post, uri_stem(Cb.configuration.uri_application_external)).with(:body => anything).
          to_return(:body => response_content.to_json)
      end

      def assert_blank_apply_url(app)
        app.apply_url.blank?.should eq true
      end

      it 'raises exception for incorrent input type (anything other than Cb::CbApplication)' do
        expect { Cb::ApplicationExternalApi.submit_app(Object.new) }.to raise_error Cb::IncomingParamIsWrongTypeException
      end

      context 'when response hash contains enough data' do
        before :each do
          stub_app_submission_to_return({ 'ApplyUrl' => 'http://delicious.baconmobile.com' })
        end

        it 'the same application object that it took as input is returned' do
          app = Cb::ApplicationExternalApi.submit_app(@app)
          app.should eq @app
          app.object_id.should eq @app.object_id
        end

        it 'sets apply_url on the application' do
          app = Cb::ApplicationExternalApi.submit_app(@app)
          app.apply_url.should eq 'http://delicious.baconmobile.com'
        end
      end

      context 'when missing ApplyUrl field' do
        it 'app redirect url is set to a blank string' do
          stub_app_submission_to_return(Hash.new)
          app = Cb::ApplicationExternalApi.submit_app(@app)
          app.apply_url.blank?.should eq true
        end
      end

    end # #submit_app

  end
end