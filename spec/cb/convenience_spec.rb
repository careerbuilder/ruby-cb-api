module Cb
  describe Convenience::ClassMethods do

    def expect_method_to_return_class(method, klass)
      returned_convenience_class = Cb.send(method)
      expect(returned_convenience_class).to be klass
    end

    def expect_method_to_return_type_of_class(method, klass, args = nil)
      returned_convenience_class = args ? Cb.send(method, args) : Cb.send(method)
      expect(returned_convenience_class).to be_a klass
    end

    context '#api_client' do
      it 'returns the main CB utility client for POSTing and GETting' do
        expect_method_to_return_class(:api_client, Cb::Utils::Api)
      end
    end

    context '#job' do
      it 'returns the job api client class' do
        expect_method_to_return_class(:job, Cb::Clients::JobV1)
      end
    end

    context '#job_detail_criteria' do
      it 'returns an instance of the job search criteria class' do
        expect_method_to_return_type_of_class(:job_details_criteria, Cb::Criteria::Job::Details)
      end
    end

    context '#category' do
      it 'returns the category api client class' do
        expect_method_to_return_class(:category, Cb::Clients::Category)
      end
    end

    context '#company' do
      it 'returns the company api client class' do
        expect_method_to_return_class(:company, Cb::Clients::Company)
      end
    end

    context '#education_code' do
      it 'returns the education api client class' do
        expect_method_to_return_class(:education_code, Cb::Clients::Education)
      end
    end

    context '#recommendation' do
      it 'returns the recommendation api client class' do
        expect_method_to_return_class(:recommendation, Cb::Clients::Recommendation)
      end
    end

    context '#application' do
      it 'returns the application api client class' do
        expect_method_to_return_class(:application, Cb::Clients::Application)
      end
    end

    context '#application_external' do
      it 'returns the application_external api client class' do
        expect_method_to_return_class(:application_external, Cb::Clients::ApplicationExternal)
      end
    end

    context '#country' do
      it 'returns the country utility class' do
        expect_method_to_return_class(:country, Cb::Utils::Country)
      end
    end

    context '#user' do
      it 'returns the user api client class' do
        expect_method_to_return_class(:user, Cb::Clients::User)
      end
    end

    context '#application' do
      it 'returns the job branding api client class' do
        expect_method_to_return_class(:job_branding, Cb::Clients::JobBranding)
      end
    end

    context '#email_subscription' do
      it 'returns the email subscription api client class' do
        expect_method_to_return_class(:email_subscription, Cb::Clients::EmailSubscription)
      end
    end

    context '#employee_types' do
      it 'returns the email subscription api client class' do
        expect_method_to_return_class(:employee_types, Cb::Clients::EmployeeTypes)
      end
    end

    context '#saved_search' do
      it 'returns the saved search api client class' do
        expect_method_to_return_class(:saved_search, Cb::Clients::SavedSearch)
      end
    end

    context '#talent_network' do
      it 'returns the TN api client class' do
        expect_method_to_return_class(:talent_network, Cb::Clients::TalentNetwork)
      end
    end


    context '#anon_saved_search' do
      it 'returns the anonymous saved search api client class' do
        expect_method_to_return_class(:anon_saved_search, Cb::Clients::AnonSavedSearch)
      end
    end

    context '#spot' do
      it 'returns the spot api client class' do
        expect_method_to_return_class(:spot, Cb::Clients::Spot)
      end
    end
  end

end