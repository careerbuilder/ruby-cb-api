module Cb
  module Utils
    class ResponseMap
      class << self
        def response_for request_class
          response_class = response_hash[request_class]
          return response_class unless response_class.nil?
          raise ResponseNotFoundError.new request_class
        end

        private

        def response_hash
          {
            Cb::Requests::AnonymousSavedSearch::Create => Cb::Responses::AnonymousSavedSearch::Create,
            Cb::Requests::AnonymousSavedSearch::Delete => Cb::Responses::AnonymousSavedSearch::Delete,

            Cb::Requests::Application::Create => Cb::Responses::Application,
            Cb::Requests::Application::Form => Cb::Responses::ApplicationForm,
            Cb::Requests::Application::Get => Cb::Responses::Application,
            Cb::Requests::Application::Update => Cb::Responses::Application,

            Cb::Requests::ApplicationExternal::SubmitApplication => Cb::Responses::ApplicationExternal::SubmitApplication,

            Cb::Requests::Category::Search => Cb::Responses::Category::Search,

            Cb::Requests::Company::Find => Cb::Responses::Company::Find,

            Cb::Requests::Education::Get => Cb::Responses::Education::Get,

            Cb::Requests::EmailSubscription::Retrieve => Cb::Responses::EmailSubscription::Response,
            Cb::Requests::EmailSubscription::Modify => Cb::Responses::EmailSubscription::Response,

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
