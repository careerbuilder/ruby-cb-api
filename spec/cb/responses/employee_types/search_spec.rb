module Cb
  describe Responses::EmployeeTypes::Search do
    let(:json_hash) do
      { 'ResponseEmployeeTypes' => {
          'EmployeeTypes' => {
            'EmployeeType' => [{'whoa' => 'nelly'}]
          }
        }
      }
    end

    before(:each) do
      allow(Responses::Metadata).to receive(:new)
      allow(Models::EmployeeType).to receive(:new)
    end

    context '#new' do
      it 'returns an employee types response object' do
        expect(Responses::EmployeeTypes::Search.new(json_hash).class).to eq Responses::EmployeeTypes::Search
      end

      it 'instantiates new model objects' do
        expect(Models::EmployeeType).to receive(:new)
        Responses::EmployeeTypes::Search.new(json_hash)
      end

      context 'when input response hash cannot be validated due to' do
        def expect_response_field_error
          expect { Responses::EmployeeTypes::Search.new(json_hash) }.to raise_error ExpectedResponseFieldMissing
        end

        context 'missing root node' do
          let(:json_hash) do { 'yey' => 'wow' } end

          it 'raises an error' do
            expect_response_field_error
          end
        end

        context 'missing EmployeeTypes node' do
          let(:json_hash) do { 'ResponseEmployeeTypes' => Hash.new } end

          it 'raises an error' do
            expect_response_field_error
          end
        end

        context 'missing EmployeeType node' do
          let(:json_hash) do { 'ResponseEmployeeTypes' => { 'EmployeeTypes' => Hash.new } } end

          it 'raises an error' do
            expect_response_field_error
          end
        end
      end
    end

    context '#models' do
      it 'each hash in the array under EmployeeType node makes a model' do
        hash_count = json_hash['ResponseEmployeeTypes']['EmployeeTypes']['EmployeeType'].count
        model_count = Responses::EmployeeTypes::Search.new(json_hash).models.count
        expect(model_count).to eq hash_count
      end
    end
  end
end