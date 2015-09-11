module Cb
  module Models
    class ReportJob
      attr_accessor :success

      def initialize(args = {})
        @success = args[:success]
      end
    end
  end
end
