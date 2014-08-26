require 'spec_helper'

module Cb
  describe Cb::Clients::Resumes do
    context 'When a single resume is asked for with .getOneByHash' do
      let(:content) {JSON.parse(File.read('spec/support/response_stubbs/resumeGet.json')) }
      let(:resume_get_call) {Cb.resumes.getOneByHash(Hash.new)}

      it {expect(resume_get_call).to be_a Responses::Resumes::ResumeGet}
      it {expect(resume_get_call.model).to be_a Cb::Models::Resume}
      it {expect(resume_get_call.model.user_identifier).to eq('userID')}
      it {expect(resume_get_call.model.resume_hash).to eq('hashMe')}
    end
  end
end
