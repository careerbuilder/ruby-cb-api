require 'spec_helper'
require 'nokogiri'

module Cb::Models
  describe ApplicationExternal do

    before :all do
      @job_did = 'J1234567890'
      @email = 'dontspammebro@whoa.net'
      @site_id = 'xxx'
      @ipath = 'shiv'
      @application = ApplicationExternal.new({job_did: @job_did, email: @email, site_id: @site_id, ipath: @ipath})
    end

    context '#new' do
      it 'should create an empty new external application' do
        @application.job_did.should == @job_did
        @application.email.should == @email
        @application.ipath.should == @ipath
        @application.site_id.should == @site_id
      end
    end

    context '#to_xml' do
      it 'returns a string of valid XML' do
        returned_xml = @application.to_xml
        # if the string fails to parse there is invalid XML being generated
        Nokogiri::XML::Document.parse(returned_xml)
        expect(returned_xml).to be_an_instance_of String
      end
    end

  end
end