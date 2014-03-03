require './spec/spec_helper'

module Cb::Models
	describe BlankApplication do
		let(:response_hash) { YAML.load open('spec/support/response_stubs/blank_application.yml') }
		let(:blank_application_hash) { response_hash['ResponseBlankApplication']['BlankApplication'] }
		let(:blank_application) { BlankApplication.new(blank_application_hash) }

		describe 'BlankApplication Models' do
			it 'sets the questions' do
				expect(blank_application.questions[0]).to be_a BlankApplication::Question
			end
		end

		describe 'Question Model' do
			let(:question) { blank_application.questions[2] }
			let(:answer) { blank_application.questions[2].answers[0] }

			it 'sets question_id' do
				expect(question.question_id).to eq('MeetsRequirements')
			end

			it 'sets question_type' do
				expect(question.question_type).to eq('JobSpecific')
			end

			it 'sets is_required' do
				expect(question.is_required).to be_false
			end

			it 'sets expected_response_format' do
				expect(question.expected_response_format).to eq('AnswerID')
			end

			it 'sets question_text' do
				expect(question.question_text).to eq('Do you meet all the requirements?')
			end

			it 'sets the answers for the question' do
				expect(answer).to be_a BlankApplication::Question::Answer
			end

		end

		describe 'Answer Model' do
			let(:answer) { blank_application.questions[2].answers[0] }

			it 'sets question_id' do
				expect(answer.question_id).to eq('MeetsRequirements')
			end
			it 'sets answer_id' do
				expect(answer.answer_id).to eq('Yes')
			end
			it 'sets answer_text' do
				expect(answer.answer_text).to eq('Yes')
			end
		end

		describe 'test' do
			let(:application) { Cb::Clients::BlankApplication.new}
			it 'should get the proper response' do
				application.get({:JobDID => 'J8A2RM68F1DL4WZ25LJ'})

			end
		end

	end
end