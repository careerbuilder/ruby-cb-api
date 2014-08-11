require 'spec_helper'

module Cb
  describe Responses::Job::Search do
    let(:json_hash) do
      {
          'ResponseJobSearch' => nil
      }
    end

    context 'when input response hash cannot be validated due to' do
      context 'nil job_hashes' do

        it 'raises an error' do
          expect { Responses::Job::Search.new(json_hash) }.
              to raise_error ExpectedResponseFieldMissing
        end
      end
    end
  end
end
