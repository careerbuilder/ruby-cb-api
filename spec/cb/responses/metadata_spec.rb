module Cb
  describe Responses::Metadata do

    context '#new' do
      let(:valid_input) { Hash.new } # valid input must act like a hash!

      context 'when passed valid input' do
        it 'sets #errors' do
          expect(Responses::Metadata.new(valid_input).errors.nil?).to eq false
        end

        it 'sets #timing' do
          expect(Responses::Metadata.new(valid_input).timing.nil?).to eq false
        end
      end
    end

  end
end
