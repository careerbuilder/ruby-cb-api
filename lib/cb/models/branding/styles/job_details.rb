module Cb
  module Branding
    module Styles

      class JobDetails < Base
        attr_accessor :container, :content, :headings

        def initialize args = {}
          super

          @container = Container.new args['Container']
          @content = Content.new args['Content']
          @headings = Headings.new args['Headings']
        end

      end
    end
  end
end