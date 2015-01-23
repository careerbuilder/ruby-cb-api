module Cb
  describe Models::EmployeeType do

    context '#new' do
      context 'when there is no input supplied' do
        def new_model
          Cb::Models::EmployeeType.new
        end

        it 'initializes with no args to empty string defaults' do
          expect(new_model.code).    to eq String.new
          expect(new_model.name).    to eq String.new
          expect(new_model.language).to eq String.new
        end
      end

      context 'when the input hash has the correct fields' do
        def new_model(hash)
          Cb::Models::EmployeeType.new(hash)
        end

        let(:populated_input) do
          { 'Code' => 'whoa', 'Name' => { '#text' => 'weird', '@language' => 'formatting' } }
        end

        it 'initializes with the values of those fields' do
          expect(new_model(populated_input).code).    to eq 'whoa'
          expect(new_model(populated_input).name).    to eq 'weird'
          expect(new_model(populated_input).language).to eq 'formatting'
        end
      end
    end

  end
end