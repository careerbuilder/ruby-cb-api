require 'spec_helper'

module Cb
  describe Cb::Clients::Resumes do
    context 'When a single resume is asked for with .get_resume_by_hash' do
      let(:content) {JSON.parse(File.read('spec/support/response_stubs/resume_get.json')) }
      let(:request) {{resume_hash: 'testHash'}}
      let(:resume_get_call) {Cb.resumes.get_resume_by_hash(request)}
      let(:model) {resume_get_call.model[0]}

      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_resume_get.gsub(':resume_hash', request[:resume_hash]))).to_return(:body => content.to_json)
      end

      it {expect(resume_get_call).to be_a Responses::Resumes::ResumeGet}
      it {expect(model).to be_a Models::Resume}
      it {expect(model.user_identifier).to eq 'userID'}
      it {expect(model.resume_hash).to eq 'hashMe'}
      it {expect(model.work_experience).to be_an Array}
      it {expect(model.work_experience[0]).to be_a Models::Resumes::WorkExperience}
      it {expect(model.salary_information).to be_a Models::Resumes::SalaryInformation}
      it {expect(model.educations).to be_an Array}
      it {expect(model.educations[0]).to be_a Models::Resumes::Education}
      it {expect(model.skills_and_qualifications).to be_a Models::Resumes::SkillsAndQualifications}
      it {expect(model.skills_and_qualifications.languages_spoken).to be_an Array}
      it {expect(model.skills_and_qualifications.languages_spoken[0]).to be_a String}
      it {expect(model.relocations).to be_an Array}
      it {expect(model.relocations[0]).to be_a Models::Resumes::Relocation}
      it {expect(model.government_and_military).to be_a Models::Resumes::GovernmentAndMilitary}
    end
  end
end