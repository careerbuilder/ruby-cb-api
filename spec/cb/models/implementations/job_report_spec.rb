require 'spec_helper'

describe Cb::Models::JobReport do
  let(:response_stub) do
    full_response = JSON.parse(File.read('spec/support/response_stubs/job_report.json'))
    full_response['JobReport'].first
  end

  context 'when the response json comes back correctly' do
    it 'initializes model without exception' do
      Cb::Models::JobReport.new(response_stub)
    end

    it 'parses fields correctly' do
      model = Cb::Models::JobReport.new(response_stub)
      expect(model.applicant_information.date_application_viewed).to eq 'Some DT'
      expect(model.applicant_information.date_applied).to eq 'Some DT'
      expect(model.applicant_information.user_attached_cover_letter).to eq true
      expect(model.applicant_information.user_current_salary).to eq 55000

      expect(model.job_information.company.company_name).to eq 'Sioke Inc.'
      expect(model.job_information.company.city).to eq 'Atlanta'
      expect(model.job_information.company.state).to eq 'GA'

      expect(model.job_information.days_til_expiration).to eq 5
      expect(model.job_information.degree_required).to eq true
      expect(model.job_information.experience_required).to eq 2
      expect(model.job_information.job_title).to eq 'Pony Engineer'

      expect(model.job_information.salary_information.applicant_salaries[0]).to be_a(Cb::Models::ApplicantSalary)
      expect(model.job_information.salary_information.degree_salaries[0]).to be_a(Cb::Models::DegreeSalary)

      expect(model.competition_information.applications_submitted).to eq 11
      expect(model.competition_information.applications_viewed).to eq 8
      expect(model.competition_information.percent_meets_education_level).to eq 50.0
      expect(model.competition_information.percent_exceeds_education_level).to eq 50.0
      expect(model.competition_information.percent_cover_letter_attached).to eq 45.0
      expect(model.competition_information.percent_employed).to eq 100.0

      expect(model.competition_information.experience_ranges[0]).to be_a(Cb::Models::Experience)
      expect(model.competition_information.applicant_locations[0]).to be_a(Cb::Models::Location)
      expect(model.competition_information.top_five_degrees[0]).to be_a(Cb::Models::Degree)
      expect(model.competition_information.top_five_majors[0]).to be_a(Cb::Models::Major)
    end
  end
end
