module Cb
  module Utils
    class ResponseMap
      class << self
        def finder request_class
          response_class = response_hash[request_class]
          return response_class unless response_class.nil?
          raise ResponseNotFoundError.new request_class
        end

        private

        def response_hash
          {
            Cb::Requests::User::ChangePassword => Cb::Responses::User::ChangePassword,
            Cb::Requests::User::CheckExisting => Cb::Responses::User::CheckExisting,
            Cb::Requests::User::Delete => Cb::Responses::User::Delete,
            Cb::Requests::User::Retrieve => Cb::Responses::User::Retrieve,
            Cb::Requests::User::TemporaryPassword => Cb::Responses::User::TemporaryPassword
          }
        end

      end
    end
    class ResponseNotFoundError < StandardError
      def initialize(args)
        super(args)
      end
    end
  end
end
