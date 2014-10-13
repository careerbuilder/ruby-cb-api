require 'json'
require 'nori'

module Cb
  module ResponseValidator
    
    class << self
      def validate(response)
        body = response.response.body rescue nil
        return Hash.new if body.nil?

        if response.code == 503
          raise Cb::SiteDown
        elsif response.code != 200
          return Hash.new if body.include?('<!DOCTYPE html')
        end
        
        try_parse_json(body) || try_parse_xml(body) || {}
      end

      private

      def try_parse_json(body)
        begin
          JSON.parse(body)
        rescue JSON::ParserError
          nil
        end
      end

      def try_parse_xml(body)
        begin
          MultiXml.parse(body, KeepRoot: true)
        rescue MultiXml::ParseError
          nil
        end
      end
    end
    
  end
end
