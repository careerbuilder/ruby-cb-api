module Cb
  module Models
    class WorkStatus
      attr_accessor :key, :translations

      def initialize(args = {})
        return if args.nil?
        @key          = args['Key'] || ''
        @translations = [ args['Description'] ].flatten.map { |translation| Translation.new translation }
      end

      class Translation
        attr_accessor :language, :value

        def initialize(args = {})
          return if args.nil?
          @language = args['Language'] || ''
          @value    = args['Value']    || ''
        end
      end
    end
    
  end
end
