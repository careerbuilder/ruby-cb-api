require 'json'
require 'active_support/core_ext/hash'

module Cb
  module ResponseValidator

    def self.validate(response)
      if response.blank? || response.response.body.blank?
        return self.get_empty_json_hash
      end

      begin
        json = JSON.parse(response.response.body)
        if json.keys.any?
          return json
        else
          return self.get_empty_json_hash
        end
      rescue JSON::ParserError
        return self.handle_parser_error(response.response.body)
      end
    end

    def self.handle_parser_error(response)
      # if it's not JSON, try XML
      xml = Nokogiri::XML.parse(response).elements.to_s
      if xml.blank?
        # if i wasn't xml either, give up and return an empty json hash
        return self.get_empty_json_hash
      else
        # if it was, return a hash from the xml
        return Hash.from_xml(xml.to_s)
      end
    end

    def self.get_empty_json_hash
      return JSON.parse('{}')
    end

  end
end