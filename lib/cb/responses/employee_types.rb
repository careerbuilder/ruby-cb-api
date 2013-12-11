module Cb
  module Responses

    class EmployeeTypes < ApiResponse
      protected

      def hash_containing_metadata
        response[root_node]
      end

      def validate_api_hash
        required_response_field(root_node, response)
        required_response_field(outer_collection_node, response[root_node])
        required_response_field(inner_collection_node, employee_types_data)
      end

      def extract_models
        extracted_employee_types_data.map { |emp_type| Models::EmployeeType.new(emp_type) }
      end

      private

      def root_node
        'ResponseEmployeeTypes'
      end

      def outer_collection_node
        'EmployeeTypes'
      end

      def inner_collection_node
        'EmployeeType'
      end

      def employee_types_data
        response[root_node][outer_collection_node]
      end

      def extracted_employee_types_data
        Utils::ResponseArrayExtractor.extract(response[root_node], outer_collection_node)
      end
    end

  end
end
