require 'spec_helper'


module Cb
  describe Cb::ApplicationExternalApi do
    context '.submit_app' do
      it 'should send external info to api', :vcr => {:cassette_name => 'job/application_external/submit_app'} do
        search = Cb.job_search_criteria.location('Atlanta, GA').radius(10).keywords('customcodes:CBDEV_applyurlyes').search()
        job = search[Random.new.rand(0..24)]

        app = Cb::CbApplicationExternal.new({:job_did => job.did, :email => 'bogus@bogus.org', :ipath => 'bogus', :site_id => 'bogus'})

        app = Cb.application_external.submit_app(app)
        expect(app.apply_url.length).to be >= 1
        expect(app.api_error).to be == false
      end

      it 'should get invalid did error from api', :vcr => {:cassette_name => 'job/application_external/submit_app_error'}  do
        app = Cb::CbApplicationExternal.new({:job_did => 'bogus-did', :email => 'bogus@bogus.org', :ipath => 'bogus', :site_id => 'bogus'})

        app = Cb.application_external.submit_app(app)
        expect(app.apply_url.blank?).to be == true
        expect(app.cb_response.errors.length).to be >= 1
        app.api_error.should == false
        expect(app.api_error).to be == false
      end

      it 'should set api error on bogus request', :vcr => { :cassette_name => 'job/application_exteral/bogus_request' } do
        correct_url = Cb.configuration.uri_application_external

        Cb.configuration.uri_application_external = Cb.configuration.uri_application_external + 'a'
        app = Cb::CbApplicationExternal.new({:job_did => 'bogus-did', :email => 'bogus@bogus.org', :ipath => 'bogus', :site_id => 'bogus'})
        app = Cb.application_external.submit_app(app)
        Cb.configuration.uri_application_external = correct_url

        app.apply_url.blank?.should be_true
        app.api_error.should == true
      end
    end
  end
end