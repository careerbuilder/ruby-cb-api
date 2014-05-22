
module Cb
  describe Cb::Utils::ResponseMap do
    context '.finder' do

      let(:response_map) { Cb::Utils::ResponseMap }

      it 'should throw an error on a bad entry' do
        expect { response_map.response_for("Hello") }.to raise_error(Cb::Utils::ResponseNotFoundError)
      end

      it 'should test anonymous saved search' do
        request = Cb::Requests::AnonymousSavedSearch
        response = Cb::Responses::AnonymousSavedSearch

        response_map.response_for(request::Create).should == response::Create
        response_map.response_for(request::Delete).should == response::Delete
      end

      it 'should test user methods' do
        request = Cb::Requests::User
        response = Cb::Responses::User

        response_map.response_for(request::ChangePassword).should == response::ChangePassword
        response_map.response_for(request::CheckExisting).should == response::CheckExisting
        response_map.response_for(request::Delete).should == response::Delete
        response_map.response_for(request::Retrieve).should == response::Retrieve
        response_map.response_for(request::TemporaryPassword).should == response::TemporaryPassword
      end

    end
  end
end
