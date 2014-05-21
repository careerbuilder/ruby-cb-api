require_relative '../base'

module Cb
  module Requests
    module AnonymousSavedSearch
      class Delete < Base

        def endpoint_uri
          Cb.configuration.uri_anon_saved_search_delete
        end

        def http_method
          :post
        end

        def body
          <<-eos
          <Request>
            <ExternalID>#{@args[:external_id]}</ExternalID>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
            <Test>#{(@args[:test] || false).to_s}</Test>
          </Request>
          eos
        end

      end
    end
  end
end
