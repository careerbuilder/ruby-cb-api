module Cb
  describe Models::EmployeeType do

    context '#new' do
      context 'when there is no input supplied' do
        def new_model
          Cb::Models::EmployeeType.new
        end

        it 'initializes with no args to empty string defaults' do
          new_model.code.    should eq String.new
          new_model.name.    should eq String.new
          new_model.language.should eq String.new
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
          new_model(populated_input).code.    should eq 'whoa'
          new_model(populated_input).name.    should eq 'weird'
          new_model(populated_input).language.should eq 'formatting'
        end
      end
    end

  end
end