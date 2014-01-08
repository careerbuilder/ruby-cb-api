module Cb
  module Branding
    module Styles

      class CompanyInfo < Base
        attr_accessor :buttons, :container, :content, :headings

        def initialize args = {}
          super

          @buttons = Buttons.new args['Buttons']
          @container = Container.new args['Container']
          @content = Content.new args['Content']
          @headings = Headings.new args['Headings']
        end
      end
    end
  end
end