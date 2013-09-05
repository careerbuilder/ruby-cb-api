require 'spec_helper'

module Cb
  describe Cb::AnonSavedSearchApi do 
    @@host_site = 'WR'
    @@dev_key = 'WDHS47J77WLS2Y0N102H'
    @@email_address = 'nbstester20131@cb.com'
    @@keywords = 'Sales'
    @@location = 'New York, NY'
    @@search_name = 'Sales Associate Job'
    @@browser_id = 'Chrome'
    @@test_flag = true

    context '.new' do 
      it 'should successfully create a new anonymous saved search' do 
        VCR.use_cassette('persist/anon_saved_search_api/create/success') do 
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
          args['Test'] = false
          a_saved_search_req = Cb.anon_saved_search_api.create args

          expect(a_saved_search_req.api_error).to eq(false)
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

          expect(a_saved_search_req.api_error).to eq(false)
          expect(a_saved_search_req.errors.nil?).to eq(false)
        end
      end

      it 'should bomb out horribly due to an api error' do
        original_uri = Cb.configuration.uri_anon_saved_search_create
        Cb.configuration.uri_anon_saved_search_create = "#{Cb.configuration.uri_anon_saved_search_create}a"
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
        args['Test'] = false
        a_saved_search_req = Cb.anon_saved_search_api.create args

        Cb.configuration.uri_anon_saved_search_create = original_uri

        expect(a_saved_search_req.api_error).to eq(true)
        expect(a_saved_search_req.errors.nil?).to eq(true)
        expect(a_saved_search_req.class).to eq(Cb::CbSavedSearch)

      end
    end

    context '.delete' do 
      it 'should successfully delete an anonymous saved search ' do 
        VCR.use_cassette('persist/anon_saved_search_api/delete/success') do 

          args_del_yay = Hash.new
          args_del_yay['ExternalID'] = 'XRHP5HV60CH0XXRV3LLK'
          args_del_yay['Test'] = false
          args_del_yay['DeveloperKey'] = @@dev_key

          a_saved_search_del_req = Cb.anon_saved_search_api.delete args_del_yay

          expect(a_saved_search_del_req.api_error).to eq(false)
          expect(a_saved_search_del_req).to eq('Success')
        end
      end

      it 'should not successfully delete an anonymous saved search' do 
        VCR.use_cassette('anon_saved_search_api/delete/failure') do 
          args_del_nay = Hash.new
          args_del_nay['ExternalID'] = 'testID'
          args_del_nay['Test'] = @@test_flag
          args_del_nay['DeveloperKey'] = @@dev_key

          a_saved_search_del_req = Cb.anon_saved_search_api.delete args_del_nay

          expect(a_saved_search_del_req.api_error).to eq(false)
          expect(a_saved_search_del_req).to_not eq('Success')
        end
      end

      it 'should bomb out horribly due to an api error ' do
        original_uri = Cb.configuration.uri_anon_saved_search_delete
        Cb.configuration.uri_anon_saved_search_delete = "#{Cb.configuration.uri_anon_saved_search_delete}a"
        args_del_yay = Hash.new
        args_del_yay['ExternalID'] = 'XRHP5HV60CH0XXRV3LLK'
        args_del_yay['Test'] = false
        args_del_yay['DeveloperKey'] = @@dev_key

        a_saved_search_del_req = Cb.anon_saved_search_api.delete args_del_yay

        Cb.configuration.uri_anon_saved_search_delete = original_uri

        expect(a_saved_search_del_req.api_error).to eq(true)
        expect(a_saved_search_del_req).to eq(nil)
      end
    end
  end
end