module Cb
  module Models
    module Branding

      class Section
        attr_accessor :type, :section_1, :section_2, :section_3, :description, :requirements, :snapshot

        def initialize(type, args = {})
          @type = type
          @section_1 = args['Section1'] || ''
          @section_2 = args['Section2'] || ''
          @section_3 = args['Section3'] || ''
          @description = args['Description'] || ''
          @requirements = args['Requirements'] || ''
          @snapshot = args['Snapshot'] || ''
        end
      end

    end
  end
end
