require 'spec_helper'

module Cb
  describe Cb::Models::User do
    context '.new' do
      it 'should create an empty new user' do
        user_status = 'being initialized in test'
        password = ''
        email = 'test@test.com'
        address_1  = '1234 Main Street'
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


        user = Cb::Models::User.new('UserStatus' => user_status,
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
        'BirthDate' => birth_date)

        
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
      end
    end

    context '.custom_value' do
        it 'should successfully find custom value' do
            user = Cb::Models::User.new('CustomValues' => { 'CustomValue' => { 'Key' => 'CustomKey', 'Value' => 'CustomVal' } })

            expect(user.custom_value('CustomKey')).to be == 'CustomVal'
            expect(user.custom_value('CustomKeyDoesNotExist').nil?).to be true
        end
        
        it 'should successfully find custom value in user with multiple custom values' do
            user = Cb::Models::User.new('CustomValues' => { 'CustomValue' => [{ 'Key' => 'CustomKey', 'Value' => 'CustomVal' }, { 'Key' => 'CustomKey2', 'Value' => 'CustomVal2' }] })

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