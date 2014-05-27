
module Cb
  describe Cb::Utils::ResponseMap do
    context '.response_for' do

      let(:response_map) { Cb::Utils::ResponseMap }

      it 'should throw an error on a bad entry' do
        expect { response_map.response_for("Hello") }.to raise_error(Cb::Utils::ResponseNotFoundError)
      end

      it 'should test application external methods' do
        request_namespace = Cb::Requests::ApplicationExternal
        #response_namespace = Cb::Responses::ApplicationExternal
        response_map.response_for(request_namespace::SubmitApplication).should == Cb::Responses::SubmitApplication
      end

      it 'should test anonymous saved search' do
        request_namespace = Cb::Requests::AnonymousSavedSearch
        response_namespace = Cb::Responses::AnonymousSavedSearch

        response_map.response_for(request_namespace::Create).should == response_namespace::Create
        response_map.response_for(request_namespace::Delete).should == response_namespace::Delete
      end

      it 'should test user methods' do
        request_namespace = Cb::Requests::User
        response_namespace = Cb::Responses::User

        response_map.response_for(request_namespace::ChangePassword).should == response_namespace::ChangePassword
        response_map.response_for(request_namespace::CheckExisting).should == response_namespace::CheckExisting
        response_map.response_for(request_namespace::Delete).should == response_namespace::Delete
        response_map.response_for(request_namespace::Retrieve).should == response_namespace::Retrieve
        response_map.response_for(request_namespace::TemporaryPassword).should == response_namespace::TemporaryPassword
      end

    end
  end
end
