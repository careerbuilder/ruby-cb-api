require 'spec_helper'

module Cb
  describe Cb::AnonSavedSearchApi do 
    @@host_site = 'WR'
    @@dev_key = 'WDHS47J77WLS2Y0N102H'
    @@email_address = 'nbstester2013@cb.com'
    @@keywords = 'Sales'
    @@location = 'New York, NY'
    @@search_name = 'Sales Associate Jobs'
    @@browser_id = 'Chrome'
    @@test_flag = true
    
    context '.new' do 
      it 'should successfully create a new anonymous saved search' do 
        VCR.use_cassette('anon_saved_search_api/create/success') do 
          args = Hash.new
          args['EmailAddress'] = @@email_address
          args['BrowserID'] = @@browser_id
          args['SessionID'] = @@email_address
          args['HostSite'] = @@host_site
          args['DeveloperKey'] = @@dev_key
          args['SearchName'] = @@search_name
          args['Keywords'] = @@keywords
          args['Location'] = @@location
          args['IsDailyEmail'] = 'None'
          args['Test'] = @@test_flag
          a_saved_search_req = Cb.anon_saved_search_api.create args

          expect(a_saved_search_req.errors.nil?).to eq(true)
          expect(a_saved_search_req.class).to eq(Cb::CbSavedSearch)
        end
      end

      it 'should return a saved search object with an error for missing email frequency' do 
        VCR.use_cassette('anon_saved_search_api/create/failure') do 
          args_bad = Hash.new
          args_bad['EmailAddress'] = @@email_address
          args_bad['BrowserID'] = @@browser_id
          args_bad['SessionID'] = @@email_address
          args_bad['HostSite'] = @@host_site
          args_bad['DeveloperKey'] = @@dev_key
          args_bad['SearchName'] = @@search_name
          args_bad['Keywords'] = @@keywords
          args_bad['Location'] = @@location
          args_bad['Test'] = @@test_flag

          a_saved_search_req = Cb.anon_saved_search_api.create args_bad

          expect(a_saved_search_req.errors.nil?).to eq(false)
        end
      end
    end
  end
end