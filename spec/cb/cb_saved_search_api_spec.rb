require 'spec_helper'

module Cb
  describe Cb::SavedSearchApi do

    @@dev_key = 'WDHS47J77WLS2Y0N102H'
    @@external_user_id = 'XRHL79L6RX5QKDDJRKVF'
    @@host_site = 'WR'

    context '.new' do
      it 'should create a new saved job search api object' do
        saved_search_request = Cb::SavedSearchApi.new
        saved_search_request.should be_a_kind_of(Cb::SavedSearchApi)
      end
    end

    context '.create' do
      it 'should send a successful request to the saved search create api v2' do
        VCR.use_cassette('saved_search/successful_create_saved_search') do
          email_frequency = 'None'
          search_name = 'Fake Job Search 1'

          user_saved_search = Cb.saved_search_api.create({'DeveloperKey'=>@@dev_key, 'IsDailyEmail'=>email_frequency,
                              'ExternalUserID'=>@@external_user_id, 'SearchName'=>search_name,
                                    'HostSite'=>@@host_site})
     
          expect(user_saved_search.cb_response.errors.nil?).to eq(true)

        end
      end

      it 'should fail to send a request to the saved search api v2' do
        VCR.use_cassette('saved_search/unsuccessful_create_saved_search') do
          email_frequency = 'None'
          search_name = 'Fake Job Search 2'

          user_saved_search = Cb.saved_search_api.create({'IsDailyEmail'=>email_frequency,
                                                          'ExternalUserID'=>@@external_user_id, 'SearchName'=>search_name,
                                                          'HostSite'=>@@host_site})

          expect(user_saved_search.cb_response.errors.nil?).to eq(false)

        end
      end
    end

    context '.update' do
      it 'should update the saved search created in this test' do
        VCR.use_cassette('saved_search/successful_update_saved_search') do
          saved_search_list = Cb::SavedSearchApi.list(@@dev_key, @@external_user_id)
          external_id = saved_search_list.first.external_id
          email_frequency = 'None'
          search_name = 'Fake Job Search Update'

          user_saved_search = Cb.saved_search_api.update({'DeveloperKey'=>@@dev_key, 'IsDailyEmail'=>email_frequency,
                                                          'ExternalUserID'=>@@external_user_id, 'SearchName'=>search_name,
                                                          'HostSite'=>@@host_site, 'ExternalID'=>external_id})
         
          expect(user_saved_search.cb_response.errors.nil?).to eq(true)

        end
      end
    end

    context '.list' do
      it 'should retrieve a list of saved searches' do
        VCR.use_cassette('saved_search/successful_list_saved_search') do

        user_saved_search = Cb.saved_search_api.list(@@dev_key, @@external_user_id)

        user_saved_search.should_not be_nil

        end
      end
    end

    context '.retrieve' do
      it 'should retrieve the first saved search' do
        VCR.use_cassette('saved_search/successful_retrieve_saved_search') do
          saved_search_list = Cb::SavedSearchApi.list(@@dev_key, @@external_user_id)
          external_id = saved_search_list.first.external_id

          user_saved_search = Cb::SavedSearchApi.retrieve(@@dev_key, @@external_user_id, external_id, @@host_site)

          expect(user_saved_search.cb_response.errors.nil?).to eq(true)

        end
      end
    end

    context '.delete' do
      it 'should delete the first saved search' do
        VCR.use_cassette('saved_search/successful_delete_saved_search') do
          saved_search_list = Cb::SavedSearchApi.list(@@dev_key, @@external_user_id)
          external_id = saved_search_list.first.external_id
          user_saved_search = Cb.saved_search_api.delete({'DeveloperKey'=>@@dev_key, 'ExternalID'=>external_id,'ExternalUserID'=>@@external_user_id, 'HostSite'=>@@host_site})
          expect(user_saved_search.cb_response.errors).to eq([])
        end
      end
    end

  end
end