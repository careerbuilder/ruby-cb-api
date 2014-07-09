require 'nokogiri'

module Cb
  module Criteria
    module User

      class Delete
        attr_accessor :external_id, :password, :test

        def initialize(args = {})
          @external_id                  = args[:external_id]   || ''
          @password                     = args[:password]      || ''
          @test                         = args[:test]          || 'false'
        end

        def to_xml
          Nokogiri::XML::Builder.new do |xml|
            xml.Request {
              xml.DeveloperKey Cb.configuration.dev_key
              xml.Password     password
              xml.ExternalID   external_id
              xml.Test         self.test # ruby has a builtin called test, confusion occurs :(
            }
          end.to_xml
        end

      end

    end
  end
end
