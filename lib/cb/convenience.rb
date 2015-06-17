module Cb
  module Convenience
    module ClassMethods

      def api_client
        Cb::Utils::Api
      end

      def job
        Cb::Clients::Job
      end

      def job_details_criteria
        Cb::Criteria::Job::Details.new
      end
  
      def category
        Cb::Clients::Category
      end

      def industry
        Cb::Clients::Industry
      end

      def company
        Cb::Clients::Company
      end
  
      def education_code
        Cb::Clients::Education
      end

      def employee_types
        Cb::Clients::EmployeeTypes
      end
  
      def recommendation
        Cb::Clients::Recommendation
      end
  
      def application
        Cb::Clients::Application
      end
  
      def application_external
        Cb::Clients::ApplicationExternal
      end
  
      def country
        Cb::Utils::Country
      end
  
      def user
        Cb::Clients::User
      end
  
      def job_branding
        Cb::Clients::JobBranding
      end
  
      def email_subscription
        Cb::Clients::EmailSubscription
      end
  
      def saved_search
        Cb::Clients::SavedSearch
      end
  
      def talent_network
        Cb::Clients::TalentNetwork
      end
  
      def anon_saved_search
        Cb::Clients::AnonSavedSearch
      end

      def language_codes
        Cb::Clients::LanguageCodes
      end
    end
  end
end
