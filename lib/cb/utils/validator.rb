require 'json'

module Cb
  module ResponseValidator

    def self.validate(response)
      if response.blank? || response.response.body.blank?
        return self.get_empty_json_hash
      end

      if response.code != 200
        # we only handle json or xml responses - html means something bad happened
        is_html = response.response.body.include?('<!DOCTYPE html')
        return self.get_empty_json_hash if is_html
      end

      begin
        json = JSON.parse(response.response.body)
        json.keys.any? ? json : self.get_empty_json_hash
      rescue JSON::ParserError
        self.handle_parser_error(response.response.body)
      end
    end

    def self.handle_parser_error(response)
      # if it's not JSON, try XML
      xml = Nokogiri::XML.parse(response).elements.to_s
      if xml.blank?
        # if i wasn't xml either, give up and return an empty json hash
        return self.get_empty_json_hash
      else
        # if it was, return a hash from the xml UNLESS it was a generic
        xml_hash = Hash.from_xml(xml.to_s)
        if xml_hash.has_key?('Response') && xml_hash['Response'].has_key?('Errors')
          return self.get_empty_json_hash
        else
          return xml_hash
        end
      end
    end

    def self.get_empty_json_hash
      Hash.new
    end

  end
end