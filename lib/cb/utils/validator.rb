require 'json'
require 'nori'

module Cb
  module ResponseValidator
    
    class << self
      def validate(response)
        raise_response_code_errors(response)
        process_response_body(response)
      end

      private

      def raise_response_code_errors(response)
        code = response.code rescue nil
        raise Cb::ServiceUnavailableError if code == 503
      end

      def process_response_body(response)
        body = response.response.body rescue nil
        return Hash.new if !body

        if response.code != 200
          return Hash.new if body.include?('<!DOCTYPE html')
        end
        
        try_parse_json(body) || try_parse_xml(body) || {}
      end

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
