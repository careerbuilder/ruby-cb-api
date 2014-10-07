require 'spec_helper'

module Cb
  describe Cb::Models::User do
    describe '#new' do
      context 'when args are given for a US user' do
        it 'should create a user model with given args' do
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

          expect(user.external_id).to eq(external_id)
          expect(user.user_status).to eq(user_status)
          expect(user.email).to eq(email)
          expect(user.address_1).to eq(address_1)
          expect(user.city).to eq(city)
          expect(user.state).to eq(state)
          expect(user.zip).to eq(zip)
          expect(user.location_code).to eq(zip)
          expect(user.country_code).to eq(country_code)
          expect(user.first_name).to eq(first_name)
          expect(user.last_name).to eq(last_name)
          expect(user.phone).to eq(phone)
          expect(user.created).to eq(created)
          expect(user.gender).to eq(gender)
          expect(user.birth_date).to eq(birth_date)
          expect(user.work_status).to eq(work_status)
        end
      end

      context 'when args are given for non US user' do
        it 'should create a user model with given args' do
          external_id = 'XUID1234'
          user_status = 'being initialized in test'
          password = ''
          email = 'test@test.com'
          address_1 = '1234 Afroditis Street'
          city = 'Kallithea'
          state = 'Attica'
          postal_code = '17672'
          country_code = 'GR'
          first_name = 'Hera'
          last_name = 'Demopoulos'
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
              'PostalCode' => postal_code,
              'CountryCode' => country_code,
              'FirstName' => first_name,
              'LastName' => last_name,
              'Phone' => phone,
              'CreatedDT' => created,
              'Gender' => gender,
              'BirthDate' => birth_date,
              'WorkStatus' => work_status)

          expect(user.external_id).to eq(external_id)
          expect(user.user_status).to eq(user_status)
          expect(user.email).to eq(email)
          expect(user.address_1).to eq(address_1)
          expect(user.city).to eq(city)
          expect(user.state).to eq(state)
          expect(user.postal_code).to eq(postal_code)
          expect(user.location_code).to eq(postal_code)
          expect(user.country_code).to eq(country_code)
          expect(user.first_name).to eq(first_name)
          expect(user.last_name).to eq(last_name)
          expect(user.phone).to eq(phone)
          expect(user.created).to eq(created)
          expect(user.gender).to eq(gender)
          expect(user.birth_date).to eq(birth_date)
          expect(user.work_status).to eq(work_status)
        end
      end
      
      context 'when no args provided' do
        it 'should create an empty user model' do
          user = Cb::Models::User.new

          expect(user.external_id).to eq('')
          expect(user.user_status).to eq('')
          expect(user.password).to eq('')
          expect(user.email).to eq('')
          expect(user.address_1).to eq('')
          expect(user.address_2).to eq('')
          expect(user.city).to eq('')
          expect(user.state).to eq('')
          expect(user.province).to eq('')
          expect(user.postal_code).to eq('')
          expect(user.zip).to eq('')
          expect(user.country_code).to eq('')
          expect(user.first_name).to eq('')
          expect(user.last_name).to eq('')
          expect(user.phone).to eq('')
          expect(user.fax).to eq('')
          expect(user.last_login).to eq('')
          expect(user.created).to eq('')
          expect(user.allow_partner_emails).to eq('')
          expect(user.allow_newsletter_emails).to eq('')
          expect(user.allow_email_from_headhunter).to eq('')
          expect(user.domain).to eq('')
          expect(user.registration_path).to eq('')
          expect(user.user_type).to eq('')
          expect(user.gender).to eq('')
          expect(user.birth_date).to eq('')
          expect(user.cobrand_code).to eq('')
          expect(user.resume_stats).to eq('')
          expect(user.custom_values).to eq('')
          expect(user.work_status).to eq('')
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