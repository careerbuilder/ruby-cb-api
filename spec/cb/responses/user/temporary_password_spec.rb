require 'cb/responses/user/temporary_password'

module Cb
  describe Responses::User::TemporaryPassword do
    let(:json_hash) do
      {
        'Errors' => '',
        'TemporaryPassword' => 'hotdog_sandwich'
      }
    end

    context '#new' do
      it 'returns a temp password response object' do
        Responses::User::TemporaryPassword.new(json_hash).should
          be_an_instance_of Responses::User::TemporaryPassword
      end

      context 'when input response hash cannot be validated due to' do
        context 'missing password node' do
          let(:json_hash) do { 'yey' => 'wow' } end

          it 'raises an error' do
            expect { Responses::User::TemporaryPassword.new(json_hash) }.
              to raise_error ExpectedResponseFieldMissing
          end
        end
      end
    end

    context '#models' do
      it 'returns the TemporaryPassword node from the response' do
        expected = json_hash['TemporaryPassword']
        response = Responses::User::TemporaryPassword.new(json_hash)
        expect(response.temp_password).to eq expected
      end
    end
  end
end
