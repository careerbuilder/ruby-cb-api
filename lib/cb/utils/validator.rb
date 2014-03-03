require 'json'
require 'nori'

module Cb
  module ResponseValidator
    
    class << self
      def validate(response)
        if response.nil? || response.response.body.nil?
          return get_empty_json_hash
        end

        if response.code != 200
          # we only handle json or xml responses - html means something bad happened
          is_html = response.response.body.include?('<!DOCTYPE html')
          return get_empty_json_hash if is_html
        end
        
        return get_empty_json_hash if response.response.body.nil?

        # Try to parse response as JSON.  Otherwise, return HTTParty-parsed XML
        begin
          json = JSON.parse(response.response.body)
          json.keys.any? ? json : get_empty_json_hash
        rescue JSON::ParserError
          handle_parser_error(response.response.body)
        end
      end

      def handle_parser_error(response_body)
        begin
          response_hash = XmlSimple.xml_in(response_body)
          # Unless there was an error, return a hash from the xml
          if response_hash.respond_to?(:has_key?) && response_hash.has_key?('Errors')
            return get_empty_json_hash
          else          
            return response_hash
          end
        rescue ArgumentError, REXML::ParseException
          get_empty_json_hash
        end
      end

      def get_empty_json_hash
        Hash.new
      end
    end
    
    # private_class_method :handle_parser_error, :get_empty_json_hash
  end
end
