module Cb
  module Models
    module JobReport
      class Company
        attr_accessor :company_name, :city, :state

        def initialize(args = {})
          @company_name			= args['CompanyName']  || String.new
          @city       			= args['City']         || String.new
          @state            = args['State']        || String.new
        end

      end
    end
  end
end
