module Cb
  module Models
    class EmployeeType
      attr_accessor	:code, :name, :language

      def initialize(args={})
        @code			= args['Code']              || String.new
        @name			= args['Name']["#text"]     rescue String.new
        @language	= args['Name']["@language"] rescue String.new
      end
    end
  end
end
