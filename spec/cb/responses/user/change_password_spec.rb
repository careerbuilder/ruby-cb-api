require 'cb/responses/user/change_password'

module Cb
  describe Responses::User::ChangePassword do
    let(:json_hash) do
      {
        'Errors' => '',
        'ResponseUserChangePW' => {
          'Request' => {},
          'Status' => 'Made it!!!!!!!!'
        }
      }
    end

    context '#new' do
      it 'returns a temp password response object' do
        expect(Responses::User::ChangePassword.new(json_hash)).to
        be_an_instance_of Responses::User::ChangePassword
      end

      context 'when input response hash cannot be validated due to' do
        context 'missing password node' do
          let(:json_hash) do { 'yey' => 'wow' } end

          it 'raises an error' do
            expect { Responses::User::ChangePassword.new(json_hash) }.
                to raise_error ExpectedResponseFieldMissing
          end
        end
      end
    end

    context '#models' do
      it 'returns the status node from the response' do
        expected = json_hash['ResponseUserChangePW']['Status']
        response = Responses::User::ChangePassword.new(json_hash)
        expect(response.model.status).to eq expected
      end
    end
  end
end
