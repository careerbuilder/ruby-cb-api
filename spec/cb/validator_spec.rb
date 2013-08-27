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


      it 'should return empty hash when body is empty', :vcr => { :cassette_name => 'validator/normal_request' } do
         response = HTTParty.post url, :body => build_retrieve_request('XRHP5HT66R55L6RVP6R9', true)
         response.response.body = ''
         validation = ResponseValidator.validate(response)
         validation.blank?.should be_true
      end

      it 'should return empty hash when body is improper json/xml', :vcr => { :cassette_name => 'validator/normal_request' } do
        response = HTTParty.post url, :body => build_retrieve_request('XRHP5HT66R55L6RVP6R9', true)
        response.response.body = 'Json'
        validation = ResponseValidator.validate(response)
        validation.blank?.should be_true
      end

      it 'should return empty hash when response is nil', :vcr => { :cassette_name => 'validator/normal_request' } do
        response = HTTParty.post url, :body => build_retrieve_request('XRHP5HT66R55L6RVP6R9', true)
        response = nil
        validation = ResponseValidator.validate(response)
        validation.blank?.should be_true
      end

      it 'should return empty hash when url is invalid', :vcr => { :cassette_name => 'validator/bad_url_request' } do
        response = HTTParty.post url[0...(url.length-1)], :body => build_retrieve_request('XRHP5HT66R55L6RVP6R9', true)
        validation = ResponseValidator.validate(response)
        validation.blank?.should be_true
      end

      it 'should return a full json hash when response status is not 200 and content is json', :vcr => { :cassette_name => 'validator/bad_url_request'} do
        response = HTTParty.post url[0...(url.length-1)], :body => build_retrieve_request('XRHP5HT66R55L6RVP6R9', true)
        response.response.body = '{"TestJson":{"Test":"True"}}'
        validation = ResponseValidator.validate(response)
        validation.blank?.should be_false
      end

      it 'should return a blank json hash when status is not 200 and content is html', :vcr => { :cassette_name => 'validator/bad_url_request' } do
        response = HTTParty.post url[0...(url.length-1)], :body => build_retrieve_request('XRHP5HT66R55L6RVP6R9', true)
        response.response.body = '<!DOCTYPE html></html>'
        validation = ResponseValidator.validate(response)
        validation.blank?.should be_true
      end

    end
  end
end
