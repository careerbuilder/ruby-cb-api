module Cb
  module Models
    module HireInsider
      class Location
        attr_accessor :number_of_applicants, :state

        def initialize(args = {})
          @number_of_applicants			= args['NumberOfApplicants']  || String.new
          @state                    = args['State']               || String.new
        end

      end
    end
  end
end
