require 'spec_helper'

module Cb
  module Criteria
    module Resumes
      describe GetByHash do
        let(:criteria) {
          GetByHash.new({ resumeHash: 'hash', externalUserID: 'user'})
        }
        let(:expected_hash){
          { :resume_hash => 'hash', :external_user_id => 'user' }
        }

        describe '#to_hash' do
          it { expect(criteria.to_hash).to eq(expected_hash)}
        end
      end
    end
  end
end