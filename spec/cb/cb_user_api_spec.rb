require 'spec_helper'

module Cb
	describe Cb::UserApi do
		context '.change_password' do
			# Needs Test node respected in API. Will change password to same password for now.
			it 'should change a user password', :vcr => { :cassette_name => 'user/change_password/success' } do
				result = Cb.user.change_password 'XRHL3TC5VWHV37S9J55S', 'BikeTire3', 'BikeTire3', true

				result.cb_response.errors.nil?.should == true
				result.cb_response.status.should == 'Success (Test)'
				result.should == true
			end

			it 'should fail without a new password', :vcr => { :cassette_name => 'user/change_password/no_new_password' } do
				result = Cb.user.change_password 'XRHL3TC5VWHV37S9J55S', 'BikeTire4', ''

				result.cb_response.errors.count.should == 1
				result.cb_response.errors[0].should == 'NewPassword requires a value'
				result.cb_response.status.should == 'Fail'
				result.should == false
			end

			it 'should fail without an old password', :vcr => { :cassette_name => 'user/change_password/no_old_password' } do
				result = Cb.user.change_password 'XRHL3TC5VWHV37S9J55S', '', 'BikeTire4'

				result.cb_response.errors.count.should == 1
				result.cb_response.errors[0].should == 'OldPassword requires a value'
				result.cb_response.status.should == 'Fail'
				result.should == false
			end

			it 'should fail without an external id', :vcr => { :cassette_name => 'user/change_password/no_external_id' } do
				result = Cb.user.change_password '', 'BikeTire3', 'BikeTire4'

				result.cb_response.errors.count.should == 1
				result.cb_response.errors[0].should == 'ExternalID requires a value'
				result.cb_response.status.should == 'Fail'
				result.should == false
			end

			it 'should fail with incorrect old password', :vcr => { :cassette_name => 'user/change_password/incorrect_old_password' } do
				result = Cb.user.change_password 'XRHL3TC5VWHV37S9J55S', 'incorrect_password', 'BikeTire4'

				result.cb_response.errors.count.should == 1
				result.cb_response.errors[0].should == 'ExternalID and password do not match.'
				result.cb_response.status.should == 'Fail'
				result.should == false
			end

			it 'should fail with bad credentials', :vcr => { :cassette_name => 'user/change_password/bad_credentials' } do
				result = Cb.user.change_password 'bad_external_id', 'bad_password', 'BikeTire4'

				result.cb_response.errors.count.should == 1
				result.cb_response.errors[0].should == 'No owned user exists for given ExternalID.'
				result.cb_response.status.should == 'Fail'
				result.should == false
			end

			it 'should fail with an insecure new password', :vcr => { :cassette_name => 'user/change_password/insecure_new_password' } do
				result = Cb.user.change_password 'XRHL3TC5VWHV37S9J55S', 'BikeTire3', 'bad_password'

				result.cb_response.errors.count.should == 1
				result.cb_response.errors[0].should == 'Your password must be between 8 - 15 characters and must contain at least three of the following: upper case letter, lower case letter, number, symbol.'
				result.cb_response.status.should == 'Fail'
				result.should == false
			end
		end

		context '.build_change_password_request' do
			it 'should build xml' do
				xml = Cb.user.send :build_change_password_request, 'a', 'b', 'c', true

				xml_wrapper = Nokogiri::XML.parse(xml).elements

				xml_wrapper.count.should == 1 # Assert one root node.
				xml_wrapper[0].name.should == 'Request' # Assert root node name.
				
				xml.include?('<ExternalID>a</ExternalID>').should == true
				xml.include?('<OldPassword>b</OldPassword>').should == true
				xml.include?('<NewPassword>c</NewPassword>').should == true
				xml.include?('<Test>true</Test>').should == true
				xml.include?("<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>").should == true
			end
		end
	end
end