module Cb
  module Models
    class Education
      attr_accessor :code, :text, :language

      def initialize(args = {})
        return if args.nil?

        @code          = args['Code'] || ''
        @language			 = args['Name']['@language'] unless args['Name'].nil?
        @text          = args['Name']['#text'] unless args['Name'].nil?
        @language      ||= ''
        @text          ||= ''
      end
    end
  end
end
