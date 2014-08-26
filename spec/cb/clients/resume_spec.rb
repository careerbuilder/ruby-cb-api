require 'spec_helper'

module Cb
  describe Cb::Clients::Resumes do
    context 'When a single resume is asked for with .get_resume_by_hash' do
      let(:content) {JSON.parse(File.read('spec/support/response_stubs/resume_get.json')) }
      let(:resume_get_call) {Cb.resumes.get_resume_by_hash(Hash.new)}

      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_resume_get)).to_return(:body => content.to_json)
      end

      it {expect(resume_get_call).to be_a Responses::Resumes::ResumeGet}
      it {expect(resume_get_call.model[0]).to be_a Cb::Models::Resume}
      it {expect(resume_get_call.model[0].user_identifier).to eq 'userID'}
      it {expect(resume_get_call.model[0].resume_hash).to eq 'hashMe'}
    end
  end
end
