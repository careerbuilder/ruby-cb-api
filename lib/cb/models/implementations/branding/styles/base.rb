module Cb
  module Models
    module Branding
      module Styles

        class Base
          attr_writer :styles

          def initialize args = {}
            @styles = args
          end

          def raw
            @styles
          end
        end

      end
    end
  end
end