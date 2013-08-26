require 'spec_helper'
require 'httparty'

module Cb
  module ResponseValidator

    describe 'Validator' do

      def build_retrieve_request(external_id, test_mode)
        builder = Nokogiri::XML::Builder.new do
          Request {
            ExternalID_ external_id
            Test_ test_mode.to_s
            DeveloperKey_ Cb.configuration.dev_key
          }
        end
        builder.to_xml
      end

      def url
        "#{Cb.configuration.base_uri_secure}/#{Cb.configuration.uri_user_retrieve}"
      end


      it 'should return empty hash when body is empty', :vcr => { :cassette_name => 'user/retrieve/success' } do
         response = HTTParty.post url, :body => build_retrieve_request('XRHP5HT66R55L6RVP6R9', true)
         response.response.body = ''
         validation = ResponseValidator.validate(response)
         validation.blank?.should be_true
      end
    end
  end
end
