module Cb
  describe Responses::Errors do
    before(:all) do @errors = ['much awesome', 'so api', 'wow'] end

    context '#new' do

      def self.run_specs
        context 'and the optional boolean arg is omitted' do
          it 'raises an api error since an error was found' do
            expect do
              Responses::Errors.new(@errors_hash)
            end.to raise_error ApiResponseError
          end
        end

        context 'and the optional boolean arg is included, set to false' do
          it 'initializes a-ok' do
            Responses::Errors.new(@errors_hash, false)
          end
        end

        context 'and the optional boolean arg is included, set to true' do
          it 'raises an api error since an error was found' do
            expect do
              Responses::Errors.new(@errors_hash, true)
            end.to raise_error ApiResponseError
          end
        end
      end

      context 'when passed a hash with "errors" node as a hash' do
        before(:all) do @errors_hash = { 'errors' => { 'error' => @errors } } end
        run_specs
      end

      context 'when passed a hash with "error" node as an array' do
        before(:all) do @errors_hash =  { 'error' => @errors } end
        run_specs
      end
    end

    before(:all) do @errors_hash = { 'errors' => { 'error' => @errors } } end

    context '#parsed' do
      it 'returns an enumerable of strings' do
        errors = Responses::Errors.new(@errors_hash, false)
        errors.parsed.respond_to?(:[])   .should eq true
        errors.parsed.respond_to?(:count).should eq true
        errors.parsed.respond_to?(:map)  .should eq true
      end
    end

    context 'any missing method' do
      it 'works as if Errors includes Enumerable' do
        errors = Responses::Errors.new(@errors_hash, false)
        errors.first
        errors.map
        errors.count
        errors.pop
      end
    end

  end
end