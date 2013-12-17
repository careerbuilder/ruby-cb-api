module Cb
  module Models
    module Branding

      class Widget
        attr_accessor :type, :url

        def initialize(type, url)
          @type = type
          @url = url
        end
      end

    end
  end
end
