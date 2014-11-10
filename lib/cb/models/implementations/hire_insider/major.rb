module Cb
  module Models
    module HireInsider
      class Major
        attr_accessor :major_name, :number_of_applicants, :percentage_of_applicants

        def initialize(args = {})
          @major_name                 = args['MajorName']            || String.new
          @number_of_applicants			  = args['NumberOfApplicants']   || 0.0
          @percentage_of_applicants   = args['PercentOfApplicants']  || 0.0
        end

      end
    end
  end
end
