module Cb
  module Models
    class Company
      attr_accessor :company_name, :city, :state

      def initialize(args = {})
        @company_name   = args['Name']  || String.new
        @city           = args['City']  || String.new
        @state          = args['State'] || String.new
      end

    end
  end
end
