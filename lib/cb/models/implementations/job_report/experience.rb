module Cb
  module Models
    class Experience
      attr_accessor :number, :range

      def initialize(args = {})
        @range    = args['Range']          || String.new
        @number   = args['NumberOfPeople'] || 0.0
      end

    end
  end
end
