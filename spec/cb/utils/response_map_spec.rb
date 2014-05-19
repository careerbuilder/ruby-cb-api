
module Cb
  describe Cb::Utils::ResponseMap do
    context '.finder' do
      it 'should test user methods' do
        Cb::Utils::ResponseMap.finder(Cb::Requests::User::ChangePassword).should == Cb::Responses::User::ChangePassword
        Cb::Utils::ResponseMap.finder(Cb::Requests::User::CheckExisting).should == Cb::Responses::User::CheckExisting
        Cb::Utils::ResponseMap.finder(Cb::Requests::User::Delete).should == Cb::Responses::User::Delete
        Cb::Utils::ResponseMap.finder(Cb::Requests::User::Retrieve).should == Cb::Responses::User::Retrieve
        Cb::Utils::ResponseMap.finder(Cb::Requests::User::TemporaryPassword).should == Cb::Responses::User::TemporaryPassword
      end
    end
  end
end
