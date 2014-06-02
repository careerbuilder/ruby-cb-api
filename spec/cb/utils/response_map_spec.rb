
module Cb
  describe Cb::Utils::ResponseMap do
    context '.response_for' do

      let(:response_map) { Cb::Utils::ResponseMap }

      it 'should throw an error on a bad entry' do
        expect { response_map.response_for("Hello") }.to raise_error(Cb::Utils::ResponseNotFoundError)
      end

      it 'should test company methods' do
        request_namespace = Cb::Requests::Company
        response_namespace = Cb::Responses::Company

        expect(response_map.response_for(request_namespace::Find)).to eq(response_namespace::Find)
      end

      it 'should test category methods' do
        request_namespace = Cb::Requests::Category
        response_namespace = Cb::Responses::Category

        expect(response_map.response_for(request_namespace::Search)).to eq(response_namespace::Search)
      end

      it 'should test application external methods' do
        request_namespace = Cb::Requests::ApplicationExternal
        response_namespace = Cb::Responses::ApplicationExternal

        expect(response_map.response_for(request_namespace::SubmitApplication)).to eq(response_namespace::SubmitApplication)
      end

      it 'should test anonymous saved search' do
        request_namespace = Cb::Requests::AnonymousSavedSearch
        response_namespace = Cb::Responses::AnonymousSavedSearch

        expect(response_map.response_for(request_namespace::Create)).to eq(response_namespace::Create)
        expect(response_map.response_for(request_namespace::Delete)).to eq(response_namespace::Delete)
      end

      it 'should test application methods' do
        request_namespace = Cb::Requests::Application
        response_namespace = Cb::Responses::Application

        expect(response_map.response_for(request_namespace::Create)).to eq(response_namespace)
        expect(response_map.response_for(request_namespace::Update)).to eq(response_namespace)
        expect(response_map.response_for(request_namespace::Get)).to eq(response_namespace)
        expect(response_map.response_for(request_namespace::Form)).to eq(Cb::Responses::ApplicationForm)
      end

      it 'should test user methods' do
        request_namespace = Cb::Requests::User
        response_namespace = Cb::Responses::User

        expect(response_map.response_for(request_namespace::ChangePassword)).to eq(response_namespace::ChangePassword)
        expect(response_map.response_for(request_namespace::CheckExisting)).to eq(response_namespace::CheckExisting)
        expect(response_map.response_for(request_namespace::Delete)).to eq(response_namespace::Delete)
        expect(response_map.response_for(request_namespace::Retrieve)).to eq(response_namespace::Retrieve)
        expect(response_map.response_for(request_namespace::TemporaryPassword)).to eq(response_namespace::TemporaryPassword)
      end
    end
  end
end
