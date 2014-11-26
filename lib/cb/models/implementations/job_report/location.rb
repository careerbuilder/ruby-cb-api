module Cb
  module Models
    class Location
      attr_accessor :number_of_applicants, :state

      def initialize(args = {})
        @state                = args['State']               || String.new
        @number_of_applicants = args['NumberOfApplicants']  || String.new
      end

    end
  end
end
