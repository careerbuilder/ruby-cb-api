require 'spec_helper'

module Cb::Models
  describe ApplicationExternal do

    before :all do
      @job_did = 'J1234567890'
      @email = 'dontspammebro@whoa.net'
      @site_id = 'xxx'
      @ipath = 'shivitandshivitgood'
      @is_external_link_apply = true
      @application = ApplicationExternal.new(
        { job_did: @job_did,
          email: @email,
          site_id: @site_id,
          is_external_link_apply: @is_external_link_apply,
          ipath: @ipath
        })
    end

    context '#new' do
      it 'should create an empty new external application' do
        expect(@application.job_did).to eq @job_did
        expect(@application.email).to eq @email
        expect(@application.ipath).to eq 'shivitands'
        expect(@application.is_external_link_apply).to eq @is_external_link_apply
        expect(@application.site_id).to eq @site_id
      end
    end

    context '#to_xml' do
      it 'returns a string of valid XML' do
        returned_xml = @application.to_xml
        expect(returned_xml).to be_an_instance_of String
      end
    end


  end
end