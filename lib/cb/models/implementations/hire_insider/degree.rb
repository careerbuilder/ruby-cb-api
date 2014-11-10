module Cb
  module Models
    module JobReport
      class Degree
        attr_accessor :degree_name, :number_of_applicants, :percentage_of_applicants

        def initialize(args = {})
          @degree_name                = args['DegreeName']            || String.new
          @number_of_applicants			  = args['NumberOfApplicants']    || 0.0
          @percentage_of_applicants   = args['PercentOfApplicants']   || 0.0
        end

      end
    end
  end
end
