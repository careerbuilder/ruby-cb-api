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
    end

    context '#response_sent' do
      context 'when initialized with a valid input hash' do
        it 'contains a DateTime extracted from the string input date' do
          target = valid_input_hash['TimeResponseSent']
          valid_instance.response_sent.should eq DateTime.parse(target)
        end
      end

      context 'when the input hash is lacking the field' do
        it 'contains a DateTime of the epoch' do
          Responses::Timing.new({}).response_sent.should eq DateTime.new
        end
      end
    end

    context '#elapsed' do
      context 'when initialized with a valid input hash' do
        it 'contains a float extracted from the string input float' do
          target = valid_input_hash['TimeElapsed']
          valid_instance.elapsed.should eq target.to_f
        end
      end

      context 'when the input hash is lacking the field' do
        it 'contains nil' do
          Responses::Timing.new({}).elapsed.should eq nil
        end
      end
    end

  end
end
