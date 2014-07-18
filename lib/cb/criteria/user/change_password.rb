require 'nokogiri'

module Cb
  module Criteria
    module User
      class ChangePassword
        attr_accessor :external_id, :old_password, :new_password,:test
        def initialize(args = {})
          @external_id                  = args[:external_id]   || ''
          @old_password                 = args[:old_password]  || ''
          @new_password                 = args[:new_password]  || ''
          @test                         = args[:test]          || 'false'
        end

        def to_xml
          Nokogiri::XML::Builder.new do |xml|
            xml.Request {
              xml.DeveloperKey Cb.configuration.dev_key
              xml.ExternalID    external_id
              xml.OldPassword   old_password
              xml.NewPassword   new_password
              xml.Test          test
            }
          end.to_xml
        end
      end
    end
  end
end
