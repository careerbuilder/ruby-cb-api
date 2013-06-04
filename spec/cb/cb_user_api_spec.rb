require 'spec_helper'

module Cb
    describe Cb::UserApi do
        context '.retrieve' do 
            it 'should retrieve a user', :vcr => { :cassette_name => 'user/retrieve/success' } do
                user = Cb.user.retrieve 'XRHP5HT66R55L6RVP6R9', true

                expect(user.cb_response.errors.nil?).to be true
                expect(user.cb_response.status).to be == 'Success (Test)'
                expect(user.nil?).to be false
            end

            it 'shoud not retrieve user because external_id is empty', :vcr => { :cassette_name => 'user/retrieve/failure_empty' } do
                user = Cb.user.retrieve '', true

                expect(user.cb_response.errors.count).to be == 1
                expect(user.cb_response.errors[0]).to be == 'ExternalID requires a value'
                expect(user.cb_response.status).to be == 'Fail (Test)'
            end

            it 'shoud not retrieve user because external_id is not used by any user', :vcr => { :cassette_name => 'user/retrieve/failure_bad_key' } do
                user = Cb.user.retrieve 'asdf', true

                expect(user.user_status).to be == 'UserNotOwned'
            end
        end

        context '.change_password' do
            # Needs Test node respected in API. Will change password to same password for now.
            it 'should change a user password', :vcr => { :cassette_name => 'user/change_password/success' } do
                result = Cb.user.change_password 'XRHL3TC5VWHV37S9J55S', 'BikeTire3', 'BikeTire3', true

        expect(result.cb_response.errors.nil?).to be true
        expect(result.cb_response.status).to be == 'Success (Test)'
        expect(result).to be true
            end

            it 'should fail without a new password', :vcr => { :cassette_name => 'user/change_password/no_new_password' } do
                result = Cb.user.change_password 'XRHL3TC5VWHV37S9J55S', 'BikeTire4', ''

        expect(result.cb_response.errors.count).to be == 1
        expect(result.cb_response.errors[0]).to be == 'NewPassword requires a value'
        expect(result.cb_response.status).to be == 'Fail'
        expect(result).to be false
            end

            it 'should fail without an old password', :vcr => { :cassette_name => 'user/change_password/no_old_password' } do
                result = Cb.user.change_password 'XRHL3TC5VWHV37S9J55S', '', 'BikeTire4'

        expect(result.cb_response.errors.count).to be == 1
        expect(result.cb_response.errors[0]).to be == 'OldPassword requires a value'
        expect(result.cb_response.status).to be == 'Fail'
        expect(result).to be false
            end

            it 'should fail without an external id', :vcr => { :cassette_name => 'user/change_password/no_external_id' } do
                result = Cb.user.change_password '', 'BikeTire3', 'BikeTire4'

        expect(result.cb_response.errors.count).to be == 1
        expect(result.cb_response.errors[0]).to be == 'ExternalID requires a value'
        expect(result.cb_response.status).to be == 'Fail'
        expect(result).to be false
            end

            it 'should fail with incorrect old password', :vcr => { :cassette_name => 'user/change_password/incorrect_old_password' } do
                result = Cb.user.change_password 'XRHL3TC5VWHV37S9J55S', 'incorrect_password', 'BikeTire4'

        expect(result.cb_response.errors.count).to be == 1
        expect(result.cb_response.errors[0]).to be == 'ExternalID and password do not match.'
        expect(result.cb_response.status).to be == 'Fail'
        expect(result).to be false
            end

            it 'should fail with bad credentials', :vcr => { :cassette_name => 'user/change_password/bad_credentials' } do
                result = Cb.user.change_password 'bad_external_id', 'bad_password', 'BikeTire4'

        expect(result.cb_response.errors.count).to be == 1
        expect(result.cb_response.errors[0]).to be == 'No owned user exists for given ExternalID.'
        expect(result.cb_response.status).to be == 'Fail'
        expect(result).to be false
            end

            it 'should fail with an insecure new password', :vcr => { :cassette_name => 'user/change_password/insecure_new_password' } do
                result = Cb.user.change_password 'XRHL3TC5VWHV37S9J55S', 'BikeTire3', 'bad_password'

        expect(result.cb_response.errors.count).to be == 1
        expect(result.cb_response.errors[0]).to be == 'Your password must be between 8 - 15 characters and must contain at least three of the following: upper case letter, lower case letter, number, symbol.'
        expect(result.cb_response.status).to be == 'Fail'
        expect(result).to be false
            end
        end

        context '.build_change_password_request' do
            it 'should build xml' do
                xml = Cb.user.send :build_change_password_request, 'a', 'b', 'c', true

                xml_wrapper = Nokogiri::XML.parse(xml).elements

        expect(xml_wrapper.count).to be == 1 # Assert one root node.
        expect(xml_wrapper[0].name).to be == 'Request' # Assert root node name.

        expect(xml.include?('<ExternalID>a</ExternalID>')).to be true
        expect(xml.include?('<OldPassword>b</OldPassword>')).to be true
        expect(xml.include?('<NewPassword>c</NewPassword>')).to be true
        expect(xml.include?('<Test>true</Test>')).to be true
        expect(xml.include?("<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>")).to be true
            end
    end

    context '.delete' do
      external_id = 'XRHN2RH6K4CVZR19H00Z'
      password = '!QA2ws3ed'

      it 'should delete a user', :vcr => { :cassette_name => 'user/delete/success' } do
        result = Cb.user.delete external_id, password, true

        expect(result.cb_response.errors.nil?).to be true
        expect(result.cb_response.status).to be == 'Success (Test)'
        expect(result).to be true
      end

      it 'should fail with no password', :vcr => { :cassette_name => 'user/delete/no_password' } do
        result = Cb.user.delete external_id, nil, true

        expect(result.cb_response.errors.nil?).to be false
        expect(result.cb_response.status).to be == 'Fail (Test)'
        expect(result).to be false
      end

      it 'should fail with no external_id', :vcr => { :cassette_name => 'user/delete/no_external_id' } do
        result = Cb.user.delete nil, password, true

        expect(result.cb_response.errors.nil?).to be false
        expect(result.cb_response.status).to be == 'Fail (Test)'
        expect(result).to be false
      end
    end

    context '.build_retrieve_request' do
      it 'should build retriev a user' do
        xml = Cb.user.send :build_retrieve_request, 'a', true

        xml_wrapper = Nokogiri::XML.parse(xml).elements

        expect(xml_wrapper.count).to be == 1 # Assert one root node.
        expect(xml_wrapper[0].name).to be == 'Request' # Assert root node name.

        expect(xml.include?('<ExternalID>a</ExternalID>')).to be true
        expect(xml.include?('<Test>true</Test>')).to be true
        expect(xml.include?("<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>")).to be true
      end
    end

    context '.build_delete_request' do
      it 'should build delete xml' do
        xml = Cb.user.send :build_delete_request, 'a', 'b', true

        xml_wrapper = Nokogiri::XML.parse(xml).elements

        expect(xml_wrapper.count).to be == 1 # Assert one root node.
        expect(xml_wrapper[0].name).to be == 'Request' # Assert root node name.

        expect(xml.include?('<ExternalID>a</ExternalID>')).to be true
        expect(xml.include?('<Password>b</Password>')).to be true
        expect(xml.include?('<Test>true</Test>')).to be true
        expect(xml.include?("<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>")).to be true
      end
    end
    end
end