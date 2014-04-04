module Cb
  describe Responses::Industry::Search do
    let(:response) do
      { 'ResponseIndustryCodes' => {
          'IndustryCodes' => {
              'IndustryCode' => [{'like' => 'whoa'}]
          }
      }
      }
    end

    before(:each) do
      Responses::Metadata.stub(:new)
      Models::Industry.stub(:new)
    end

    context '#new' do
      it 'returns an industry response object' do
        expect(Responses::Industry::Search.new(response)).to be_instance_of(Responses::Industry::Search)
      end

      it 'instantiates new model objects' do
        Models::Industry.should_receive(:new)
        Responses::Industry::Search.new(response)
      end

      context 'when input response hash cannot be validated due to' do
        def expect_response_field_error
          expect { Responses::Industry::Search.new(response) }.to raise_error ExpectedResponseFieldMissing
        end

        context 'missing root node' do
          let(:response) do { 'herp' => 'derp' } end

          it 'raises an error' do
            expect_response_field_error
          end
        end

        context 'missing IndustryCodes node' do
          let(:response) do { 'ResponseIndustryCodes' => Hash.new } end

          it 'raises an error' do
            expect_response_field_error
          end
        end

        context 'missing IndustryCode node' do
          let(:response) do { 'ResponseIndustryCodes' => { 'IndustryCodes' => Hash.new } } end

          it 'raises an error' do
            expect_response_field_error
          end
        end
      end
    end

    context '#models' do
      it 'each hash in the array under IndustryCodes node makes a model' do
        hash_count = response['ResponseIndustryCodes']['IndustryCodes']['IndustryCode'].count
        model_count = Responses::Industry::Search.new(response).models.count
        expect(model_count).to eq(hash_count)
      end
    end
  end
end