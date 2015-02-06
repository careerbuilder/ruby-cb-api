require 'cb/responses/user/retrieve'

module Cb
  describe Responses::User::Retrieve do
    let(:json_hash) do
      {
        'Errors' => '',
        'ResponseUserInfo' => {
            'Request' => "HEY"
        }
      }
    end

    context '#new' do
      it 'returns a temp password response object' do
        expect(Responses::User::Retrieve.new(json_hash)).to be_an_instance_of Responses::User::Retrieve
      end

      context 'when input response hash cannot be validated due to' do
        context 'missing password node' do
          let(:json_hash) do { 'yey' => 'wow' } end

          it 'raises an error' do
            expect { Responses::User::Retrieve.new(json_hash) }.
              to raise_error ExpectedResponseFieldMissing
          end
        end
      end
    end

    context '#models' do
      it 'returns the TemporaryPassword node from the response' do
        response = Responses::User::Retrieve.new(json_hash)
        expect(response.model).to be_an_instance_of Cb::Models::User
      end
    end
  end
end
