module Cb
  module Models
    class Salary < ApiResponseModel
      attr_accessor :applicant_salaries, :degree_salaries

      def set_model_properties
        @applicant_salaries = api_response['ApplicantSalaries'].collect do |salary|
          Models::ApplicantSalary.new(salary)
        end

        @degree_salaries = api_response['DegreeSalaries'].collect do |salary|
          Models::DegreeSalary.new(salary)
        end
      end

      def required_fields
        %w(ApplicantSalaries DegreeSalaries)
      end

    end

    class ApplicantSalary
      attr_accessor :range, :number

      def initialize(args={})
        @range  = args['Range']           || String.new
        @number = args['NumberOfPeople']  || 0.0
      end
    end

    class DegreeSalary
      attr_accessor :degree_name, :number

      def initialize(args={})
        @range    = args['Name']            || String.new
        @number   = args['NumberOfPeople']  || 0.0
      end
    end


  end
end
