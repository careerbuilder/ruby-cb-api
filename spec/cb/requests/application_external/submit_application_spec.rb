require 'spec_helper'

module Cb
  describe Cb::Requests::ApplicationExternal::SubmitApplication do

    context 'initialize without arguments' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::ApplicationExternal::SubmitApplication.new({}) }

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_application_external)
          expect(@request.http_method).to eq(:post)
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq(nil)
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq(nil)
        end

        it 'should have a basic body' do
          expect(@request.body).to eq <<-eos
          <Request>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
            <EmailAddress></EmailAddress>
            <JobDID></JobDID>
            <SiteID></SiteID>
            <IPath></IPath>
            <IsExternalLinkApply></IsExternalLinkApply>
            <HostSite>#{Cb.configuration.host_site}</HostSite>
            <SessionIdentifier></SessionIdentifier>
          </Request>
          eos
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::ApplicationExternal::SubmitApplication.new({
            host_site: 'host site',
            email_address: 'email address',
            job_did: 'job did',
            site_id: 'site id',
            ipath: 'ipath id over length of 10',
            is_external_link_apply: 'is external link apply',
            sid: 'session id'
          })
        end

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_application_external)
          expect(@request.http_method).to eq(:post)
        end

        it 'should have a correct query string' do
          expect(@request.query).to eq(nil)
        end

        it 'should have correct headers' do
          expect(@request.headers).to eq(nil)
        end

        it 'should have a correct body' do
          expect(@request.body).to eq <<-eos
          <Request>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
            <EmailAddress>email address</EmailAddress>
            <JobDID>job did</JobDID>
            <SiteID>site id</SiteID>
            <IPath>ipath id o</IPath>
            <IsExternalLinkApply>is external link apply</IsExternalLinkApply>
            <HostSite>host site</HostSite>
            <SessionIdentifier>session id</SessionIdentifier>
          </Request>
          eos
        end
      end
    end

  end
end
