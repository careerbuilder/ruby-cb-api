module Cb
  describe Responses::EmployeeTypes do
    let(:json_hash) do
      { 'ResponseEmployeeTypes' => {
          'EmployeeTypes' => {
            'EmployeeType' => [{'whoa' => 'nelly'}]
          }
        }
      }
    end

    before(:each) do
      Responses::Metadata.stub(:new)
      Models::EmployeeType.stub(:new)
    end

    context '#new' do
      it 'returns an employee types response object' do
        Responses::EmployeeTypes.new(json_hash).class.should eq Responses::EmployeeTypes
      end
    end

  end
end