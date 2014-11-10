module Cb
  module Models
    module HireInsider
      class Experience
        attr_accessor :number, :range

        def initialize(args = {})
          @range		= args["Range"]    || String.new
          @number		= args["Number"]   || 0.0
        end

      end
    end
  end
end