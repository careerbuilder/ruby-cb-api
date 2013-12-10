module Cb
  module Models
    class EmployeeType

      attr_accessor	:code, :name, :language

      def initialize(args={})
        @code			||= args['Code'] || ''
        @name			||= args['Name']["#text"] || ''
        @language	||= args['Name']["@language"] || ''
      end
    end
  end
end
