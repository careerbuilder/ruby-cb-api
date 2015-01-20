require 'spec_helper'

module Cb
  module Models
    describe '#new' do
      let (:resume) { Models::Resume.new(resume_hash) }
      let(:error) do
        begin
          resume
        rescue ExpectedResponseFieldMissing => e
          e.message
        end
      end

      context 'When APIResponse has work experience' do
        let(:resume_hash) do
          { 'workExperience' => [{ 'jobTitle' => 'jerbs', 'currentlyEmployedHere' => 'false' }],
            'userIdentifier' => 'user' }
        end

        it { expect(resume.work_experience[0]).to_not be_nil }
      end

      context 'when APIResponse has invalid work experience' do
        context 'and specifically its the jobTitle missing' do
          let(:resume_hash) do
            { 'workExperience' => [{ 'currentlyEmployedHere' => 'false' }],
              'userIdentifier' => 'user' }
          end

          it { expect(error).to eq('jobTitle') }
        end

        context 'and specifically its the currentlyEmployedHere missing' do
          let(:resume_hash) do
            { 'workExperience' => [{ 'jobTitle' => 'jerbs' }], 'userIdentifier' => 'user' }
          end

          it { expect(error).to eq('currentlyEmployedHere') }
        end
      end

      context 'When APIResponse has salary information' do
        let(:resume_hash) do
          { 'salaryInformation' => { 'workExperienceId' => 'test1', 'PerHourOrPerYear' => 'PerHour',
                                     'mostRecentPayAmount' => 100.00 }, 'userIdentifier' => 'user' }
        end

        it { expect(resume.salary_information.work_experience_id).to_not be_nil }
        it { expect(resume.salary_information.most_recent_pay_amount).to_not be_nil }
      end

      context 'When APIResponse hash invalid salary information' do
        context 'and it is specifically the PerHourOrPerYear missing' do
          let(:resume_hash) do
            { 'salaryInformation' => { 'workExperienceId' => 'test1',
                                       'mostRecentPayAmount' => 100.00 }, 'userIdentifier' => 'user' }
          end

          it { expect(error).to eq('PerHourOrPerYear') }
        end

        context 'and it is specifically the mostRecentPayAmount missing' do
          let(:resume_hash) do
            { 'salaryInformation' => { 'workExperienceId' => 'test1', 'PerHourOrPerYear' => 'PerHour' },
              'userIdentifier' => 'user' }
          end

          it { expect(error).to eq('mostRecentPayAmount') }
        end
      end

      context 'When APIResponse has education' do
        let(:resume_hash) do
          { 'educations' => [{ 'schoolName' => 'skool', 'majorOrProgram' => 'major' }],
            'userIdentifier' => 'user' }
        end

        it { expect(resume.educations[0].school_name).to_not be_nil }
        it { expect(resume.educations[0].major_or_program).to_not be_nil }
      end

      context 'When APIResponse hash invalid education' do
        context 'and it is specifically the schoolName missing' do
          let(:resume_hash) do
            { 'educations' => [{ 'majorOrProgram' => 'major' }],
              'userIdentifier' => 'user' }
          end

          it { expect(error).to eq('schoolName') }
        end

        context 'and it is specifically the majorOrProgram missing' do
          let(:resume_hash) do
            { 'educations' => [{ 'schoolName' => 'skool' }],
              'userIdentifier' => 'user' }
          end

          it { expect(error).to eq('majorOrProgram') }
        end
      end

      context 'When APIResponse has skills and qualifications' do
        let(:resume_hash) do
          { 'skillsAndQualifications' => { 'accreditationsAndCertifications' => 'skillz' },
            'userIdentifier' => 'user' }
        end

        it { expect(resume.skills_and_qualifications.accreditations_and_certifications).to_not be_nil }
        context 'and when it has a language in its skills' do
          before do
            resume_hash['skillsAndQualifications'].merge!('languagesSpoken' => ['english'])
          end

          it { expect(resume.skills_and_qualifications.languages_spoken[0]).to_not be_nil }
        end
      end

      context 'When APIResponse has Relocation' do
        let(:resume_hash) do
          { 'relocations' => [{ 'city' => 'city', 'adminArea' => 'st', 'countryCode' => 'co' }],
            'userIdentifier' => 'user' }
        end

        it { expect(resume.relocations[0].city).to_not be_nil }
        it { expect(resume.relocations[0].admin_area).to_not be_nil }
        it { expect(resume.relocations[0].country_code).to_not be_nil }
      end

      context 'When APIResponse hash invalid Relocation' do
        context 'and it is specifically the city missing' do
          let(:resume_hash) do
            { 'relocations' => [{ 'adminArea' => 'st', 'countryCode' => 'co' }],
              'userIdentifier' => 'user' }
          end

          it { expect(error).to eq('city') }
        end

        context 'and it is specifically the adminArea missing' do
          let(:resume_hash) do
            { 'relocations' => [{ 'city' => 'city', 'countryCode' => 'co' }],
              'userIdentifier' => 'user' }
          end

          it { expect(error).to eq('adminArea') }
        end

        context 'and it is specifically the countryCode missing' do
          let(:resume_hash) do
            { 'relocations' => [{ 'city' => 'city', 'adminArea' => 'st' }],
              'userIdentifier' => 'user' }
          end

          it { expect(error).to eq('countryCode') }
        end
      end

      context 'When APIResponse has government and military' do
        let(:resume_hash) do
          { 'governmentAndMilitary' => { 'hasSecurityClearance' => true, 'militaryExperience' => 'army' },
            'userIdentifier' => 'user' }
        end

        it { expect(resume.government_and_military.has_security_clearance).to be_truthy }
        it { expect(resume.government_and_military.military_experience).to_not be_nil }
      end

      context 'When APIResponse hash invalid Relocation' do
        context 'and it is specifically the hasSecurityClearance missing' do
          let(:resume_hash) do
            { 'governmentAndMilitary' => { 'militaryExperience' => 'army' },
              'userIdentifier' => 'user' }
          end

          it { expect(error).to eq('hasSecurityClearance') }
        end

        context 'and it is specifically the militaryExperience missing' do
          let(:resume_hash) do
            { 'governmentAndMilitary' => { 'hasSecurityClearance' => true },
              'userIdentifier' => 'user' }
          end

          it { expect(error).to eq('militaryExperience') }
        end
      end
    end
  end
end
