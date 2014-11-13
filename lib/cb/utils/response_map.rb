module Cb
  module Utils
    class ResponseMap
      class << self
        def response_for request_class
          response_class = response_hash[request_class]
          return response_class unless response_class.nil?
          raise ResponseNotFoundError.new request_class
        end

        protected

        def response_hash_extension
          {
            response_hash_extension_not_implemented: true
          }
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

            Cb::Requests::Recommendations::Resume => Cb::Responses::Recommendations,

            Cb::Requests::Resumes::Get => Cb::Responses::Resume,
            Cb::Requests::Resumes::Put => Cb::Responses::Resume,
            Cb::Requests::Resumes::Delete => Cb::Responses::Resume,
            Cb::Requests::Resumes::List => Cb::Responses::ResumeList,
            Cb::Requests::Resumes::LanguageCodes => Cb::Responses::LanguageCodes,

            Cb::Requests::DataLists::CountryCodes => Cb::Responses::CountryCodes,
            Cb::Requests::DataLists::ResumeEducation => Cb::Responses::ResumeEducation,

            Cb::Requests::User::ChangePassword => Cb::Responses::User::ChangePassword,
            Cb::Requests::User::CheckExisting => Cb::Responses::User::CheckExisting,
            Cb::Requests::User::Delete => Cb::Responses::User::Delete,
            Cb::Requests::User::Retrieve => Cb::Responses::User::Retrieve,
            Cb::Requests::User::TemporaryPassword => Cb::Responses::User::TemporaryPassword,

            Cb::Requests::WorkStatus::List => Cb::Responses::WorkStatus::List
          }.merge response_hash_extension
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
