require 'json'

module Cb
  module Clients
    class EmailSubscription

      def self.retrieve_by_did(did, host_site = '')
        my_api = Cb::Utils::Api.instance
        json_hash = my_api.cb_get(Cb.configuration.uri_subscription_retrieve, :query => {:ExternalID => did, :Hostsite => host_site})

        if json_hash.has_key?('SubscriptionValues') && !json_hash['SubscriptionValues'].nil?
          subscription = Models::EmailSubscription.new(json_hash['SubscriptionValues'])
          my_api.append_api_responses(subscription, json_hash['SubscriptionValues'])
        end
        my_api.append_api_responses(subscription, json_hash)
      end
    end
  end
end
