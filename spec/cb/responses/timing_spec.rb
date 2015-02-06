module Cb
  describe Responses::Timing do
    let(:valid_input_hash) do
      { 'TimeResponseSent' => "-4712-01-01T00:00:00+00:00", 'TimeElapsed' => '0.01337' }
    end

    def valid_instance
      Responses::Timing.new(valid_input_hash)
    end

    context '#new' do
      context 'when initialized with a valid input hash' do
        it 'raises no error' do
          valid_instance
        end
      end

      context 'when initialized with an invalid input hash, raises an error due to: ' do
        it 'response being nil' do
          expect { Responses::Timing.new(nil) }.to raise_error ExpectedResponseFieldMissing
        end

        it 'response not responding to #[]' do
          expect { Responses::Timing.new(Object.new) }.to raise_error ExpectedResponseFieldMissing
        end
      end

      context "when the timing hash looks valid but doesn't coerce to a float" do
        it 'sets the #elapsed field to nil' do
          valid_input_hash['TimeElapsed'] = 'lolol'
          timing = Responses::Timing.new(valid_input_hash)
          expect(timing.elapsed).to be_nil
        end
      end
    end

    context '#response_sent' do
      context 'when initialized with a valid input hash' do
        it 'contains a DateTime extracted from the string input date' do
          target = valid_input_hash['TimeResponseSent']
          expect(valid_instance.response_sent).to eq DateTime.parse(target)
        end
      end

      context 'when the input hash is lacking the field' do
        it 'contains nil' do
          expect(Responses::Timing.new({}).response_sent).to eq nil
        end
      end
    end

    context '#elapsed' do
      context 'when initialized with a valid input hash' do
        it 'contains a float extracted from the string input float' do
          target = valid_input_hash['TimeElapsed']
          expect(valid_instance.elapsed).to eq target.to_f
        end
      end

      context 'when the input hash is lacking the field' do
        it 'contains nil' do
          expect(Responses::Timing.new({}).elapsed).to eq nil
        end
      end
    end

  end
end
