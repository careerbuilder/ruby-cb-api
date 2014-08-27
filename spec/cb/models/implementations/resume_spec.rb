require 'spec_helper'

module CB
  module Models
    describe '#new' do
      let (:resume) {Cb::Models::Resume.new(resume_hash)}

      context 'When APIResponse has work experience' do
        let(:resume_hash) do
          {'workExperience' => [{'jobTitle' => 'jerbs', 'currentlyEmployedHere' => 'false'}],
          'userIdentifier' => 'user'}
        end

        it {expect(resume.work_experience[0].job_title).to eq 'jerbs'}
      end

      context 'When APIResponse has salary information' do
        let(:resume_hash) do
          {'salaryInformation' => {'jobTitle' => 'jerbs', 'PerHourOrPerYear' => 'PerHour',
          'mostRecentPayAmount' => 100.00},'userIdentifier' => 'user'}
        end

        it {expect(resume.salary_information.job_title).to eq 'jerbs'}
        it {expect(resume.salary_information.most_recent_pay_amount).to eq 100.00}
      end

      context 'When APIResponse has education' do
        let(:resume_hash) do
          {'educations' => [{'schoolName' => 'skool', 'majorOrProgram' => 'major'}],
           'userIdentifier' => 'user'}
        end

        it {expect(resume.educations[0].school_name).to eq 'skool'}
        it {expect(resume.educations[0].major_or_program).to eq 'major'}
      end

      context 'When APIResponse has skills and qualifications' do
        let(:resume_hash) do
          {'skillsAndQualifications' => {'accreditationsAndCertifications' => 'skillz'},
           'userIdentifier' => 'user'}
        end

        it {expect(resume.skills_and_qualifications.accreditations_and_certifications).to eq 'skillz'}
        context 'and when it has a language in its skills' do
          before do
            resume_hash['skillsAndQualifications'].merge!({'languagesSpoken' => ['english']})
          end

          it {expect(resume.skills_and_qualifications.languages_spoken[0]).to eq 'english'}
        end
      end

      context 'When APIResponse has Relocation' do
        let(:resume_hash) do
          {'relocations' => [{'city' => 'city', 'adminArea' => 'st', 'countryCode' => 'co'}],
           'userIdentifier' => 'user'}
        end

        it {expect(resume.relocations[0].city).to eq 'city'}
        it {expect(resume.relocations[0].admin_area).to eq 'st'}
        it {expect(resume.relocations[0].country_code).to eq 'co'}
      end

      context 'When APIResponse has government and military' do
        let(:resume_hash) do
          {'governmentAndMilitary' => {'hasSecurityClearance' => true, 'militaryExperience' => 'army'},
           'userIdentifier' => 'user'}
        end

        it {expect(resume.government_and_military.has_security_clearance).to eq true}
        it {expect(resume.government_and_military.military_experience).to eq 'army'}
      end
    end
  end
end