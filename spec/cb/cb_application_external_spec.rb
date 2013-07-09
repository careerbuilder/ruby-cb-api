require 'spec_helper'

module Cb
  describe Cb::CbApplication do
    context '.new' do
      it 'should create an empty new external application' do
        job_did = 'J1234567890'
        email = 'dontspammebro@whoa.net'
        site_id = 'xxx'
        ipath = 'shiv'

        application = Cb::CbApplicationExternal.new({:job_did => job_did, :email => email, :site_id => site_id, :ipath => ipath})

        application.job_did.should == job_did
        application.email.should == email
        application.ipath.should == ipath
        application.site_id.should == site_id
      end
    end
  end
end