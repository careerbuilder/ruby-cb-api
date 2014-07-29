require 'spec_helper'

module Cb
  describe Cb::Models::User do
    describe '#new' do
      context 'when args are given' do
        it 'should create a user with given args' do
          external_id = 'XUID1234'
          user_status = 'being initialized in test'
          password = ''
          email = 'test@test.com'
          address_1 = '1234 Main Street'
          city = 'Bogart'
          state = 'Georgia'
          zip = '30622'
          country_code = '1'
          first_name = 'Benjamin'
          last_name = 'Schmaltz'
          phone = '706-123-4567'
          created = Time.now
          gender = 'male'
          birth_date = Date.today-40
          work_status = 'US Citizen'


          user = Cb::Models::User.new(
            'ResponseExternalID' => external_id,
            'UserStatus' => user_status,
            'Email' => email,
            'Address1' => address_1,
            'City' => city,
            'State' => state,
            'Zip' => zip,
            'CountryCode' => country_code,
            'FirstName' => first_name,
            'LastName' => last_name,
            'Phone' => phone,
            'CreatedDT' => created,
            'Gender' => gender,
            'BirthDate' => birth_date,
            'WorkStatus' => work_status)

          user.external_id.should == external_id
          user.user_status.should == user_status
          user.email.should == email
          user.address_1.should == address_1
          user.city.should == city
          user.state.should == state
          user.zip.should == zip
          user.country_code.should == country_code
          user.first_name.should == first_name
          user.last_name.should == last_name
          user.phone.should == phone
          user.created.should == created
          user.gender.should == gender
          user.birth_date.should == birth_date
          user.work_status == work_status
        end
      end
      
      context 'when no args provided' do
        it 'should create an empty user' do
          user = Cb::Models::User.new

          expect(user.external_id).should eq('')
          expect(user.user_status).should eq('')
          expect(user.password).should eq('')
          expect(user.email).should eq('')
          expect(user.address_1).should eq('')
          expect(user.address_2).should eq('')
          expect(user.city).should eq('')
          expect(user.state).should eq('')
          expect(user.province).should eq('')
          expect(user.postal_code).should eq('')
          expect(user.zip).should eq('')
          expect(user.country_code).should eq('')
          expect(user.first_name).should eq('')
          expect(user.last_name).should eq('')
          expect(user.phone).should eq('')
          expect(user.fax).should eq('')
          expect(user.last_login).should eq('')
          expect(user.created).should eq('')
          expect(user.allow_partner_emails).should eq('')
          expect(user.allow_newsletter_emails).should eq('')
          expect(user.allow_email_from_headhunter).should eq('')
          expect(user.domain).should eq('')
          expect(user.registration_path).should eq('')
          expect(user.user_type).should eq('')
          expect(user.gender).should eq('')
          expect(user.birth_date).should eq('')
          expect(user.cobrand_code).should eq('')
          expect(user.resume_stats).should eq('')
          expect(user.custom_values).should eq('')
          expect(user.work_status).should eq('')
        end
      end
    end

    context '.custom_value' do
      it 'should successfully find custom value' do
        user = Cb::Models::User.new('CustomValues' => {'CustomValue' => {'Key' => 'CustomKey', 'Value' => 'CustomVal'}})

        expect(user.custom_value('CustomKey')).to be == 'CustomVal'
        expect(user.custom_value('CustomKeyDoesNotExist').nil?).to be true
      end

      it 'should successfully find custom value in user with multiple custom values' do
        user = Cb::Models::User.new('CustomValues' => {'CustomValue' => [{'Key' => 'CustomKey', 'Value' => 'CustomVal'}, {'Key' => 'CustomKey2', 'Value' => 'CustomVal2'}]})

        expect(user.custom_value('CustomKey')).to be == 'CustomVal'
        expect(user.custom_value('CustomKey2')).to be == 'CustomVal2'
      end

      it 'should fail to find custom value because key does not exist' do
        user = Cb::Models::User.new

        expect(user.custom_value('CustomKeyDoesNotExist').nil?).to be true
      end
    end
  end
end