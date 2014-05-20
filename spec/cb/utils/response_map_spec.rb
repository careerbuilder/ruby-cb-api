
module Cb
  describe Cb::Utils::ResponseMap do
    context '.finder' do
      it 'should throw an error on a bad entry' do
        expect { Cb::Utils::ResponseMap.response_for("Hello") }.to raise_error(Cb::Utils::ResponseNotFoundError)
      end

      it 'should test user methods' do
        Cb::Utils::ResponseMap.response_for(Cb::Requests::User::ChangePassword).should == Cb::Responses::User::ChangePassword
        Cb::Utils::ResponseMap.response_for(Cb::Requests::User::CheckExisting).should == Cb::Responses::User::CheckExisting
        Cb::Utils::ResponseMap.response_for(Cb::Requests::User::Delete).should == Cb::Responses::User::Delete
        Cb::Utils::ResponseMap.response_for(Cb::Requests::User::Retrieve).should == Cb::Responses::User::Retrieve
        Cb::Utils::ResponseMap.response_for(Cb::Requests::User::TemporaryPassword).should == Cb::Responses::User::TemporaryPassword
      end

    end
  end
end
