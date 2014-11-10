module Cb
  module Models
    module JobReport
      class Salary < ApiResponseModel
        attr_accessor :applicant_salaries, :degree_salary

        def set_model_properties
          @applicant_salaries = api_response['ApplicantSalaries'].collect do |salary|
            JobReport::ApplicantSalary.new(salary)
          end

          @degree_salary = api_response['DegreeSalaries'].collect do |salary|
            JobReport::DegreeSalary.new(salary)
          end
        end

        def required_fields
          %w(ApplicantSalaries DegreeSalaries)
        end
      end

      class ApplicantSalary
        attr_accessor :range, :number

        def initialize(args={})
          @range	  = args["Range"]    || String.new
          @number	  = args["Number"]   || String.new
        end
      end

      class DegreeSalary
        attr_accessor :degree_name, :number

        def initialize(args={})
          @range					= args["DegreeName"]        || String.new
          @number					= args["Number"]            || String.new
        end
      end


    end
  end
end