module Cb
  module Models
    module JobReport
      class Experience < ApiResponseModel
        attr_accessor :number, :range

        def set_model_properties
          @number		= api_response["Number"]   || String.new
          @range		= api_response["Range"]    || String.new
        end

        def required_fields
          ['Experience']
        end
      end

    end
  end
end