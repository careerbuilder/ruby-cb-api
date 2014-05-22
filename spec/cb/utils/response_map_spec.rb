
module Cb
  describe Cb::Utils::ResponseMap do
    context '.finder' do

      let(:response_map) { Cb::Utils::ResponseMap }

      it 'should throw an error on a bad entry' do
        expect { response_map.response_for("Hello") }.to raise_error(Cb::Utils::ResponseNotFoundError)
      end

      it 'should test application external methods' do
        response_map.response_for(Cb::Requests::ApplicationExternal::SubmitApplication).should == Cb::Responses::ApplicaationExternal::SubmitApplication
      end

      it 'should test user methods' do
        response_map.response_for(Cb::Requests::User::ChangePassword).should == Cb::Responses::User::ChangePassword
        response_map.response_for(Cb::Requests::User::CheckExisting).should == Cb::Responses::User::CheckExisting
        response_map.response_for(Cb::Requests::User::Delete).should == Cb::Responses::User::Delete
        response_map.response_for(Cb::Requests::User::Retrieve).should == Cb::Responses::User::Retrieve
        response_map.response_for(Cb::Requests::User::TemporaryPassword).should == Cb::Responses::User::TemporaryPassword
      end


    end
  end
end
