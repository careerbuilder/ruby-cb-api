# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'spec_helper'

describe Cb::Models::Application::Form do
  let(:response_stub) do
    full_response = JSON.parse(File.read('spec/support/response_stubs/application_form.json'))
    full_response['Results'].first
  end

  context 'when the response json comes back correctly' do
    it 'initializes model without exception' do
      Cb::Models::Application::Form.new(response_stub)
    end

    it 'parses fields correctly' do
      model = Cb::Models::Application::Form.new(response_stub)
      expect(model.job_did).to eq 'JHT2*********'
      expect(model.job_title).to eq 'Licensed Practical Nurse - LPN (Nonprofit Social Services - Nursing)'
      expect(model.is_shared_apply).to be_falsey
      expect(model.question_list).to be_an_instance_of Array
      expect(model.question_list.first).to be_an_instance_of Cb::Models::Application::Question
      expect(model.requirements).to eq 'Our ideal Licensed Practical Nurse has excellent listening**********'
      expect(model.degree_required).to eq '2 Year Degree'
      expect(model.travel_required).to eq 'Negligible'
      expect(model.experience_required).to eq 'Yay'
      expect(model.external_application).to be_falsey
      expect(model.total_questions).to eq 11
      expect(model.total_required_questions).to eq 10
    end
  end

  context 'when the QuestionList field is empty' do
    it 'sets an empty array to the question_list attr' do
      response_stub['QuestionList'] = ''
      model = Cb::Models::Application::Form.new(response_stub)
      expect(model.question_list).to be_an_instance_of Array
      expect(model.question_list.empty?).to be_truthy
    end
  end

  describe Cb::Models::Application::Question do
    let(:question_stub) { response_stub['QuestionList'].last }

    context 'when the response json is well-formed' do
      it 'initializes without exception' do
        Cb::Models::Application::Question.new(question_stub)
      end

      it 'parses fields correctly' do
        question = Cb::Models::Application::Question.new(question_stub)
        expect(question.max_characters).to eq 32
        expect(question.min_characters).to eq 1
        expect(question.expected_response_format).to eq 'Text 32'
        expect(question.is_required).to eq true
        expect(question.question_id).to eq 'ApplicantPhone'
        expect(question.question_text).to eq 'Your phone number'
        expect(question.question_type).to eq 'ContactInfo'
        expect(question.answers).to be_an_instance_of Array
        expect(question.answers.count).to eq 2
      end
    end

    context 'when the Answers field is empty' do
      it 'sets an empty array to the answers attr' do
        question_stub['Answers'] = ''
        model = Cb::Models::Application::Question.new(question_stub)
        expect(model.answers).to be_an_instance_of Array
        expect(model.answers.empty?).to be_truthy
      end
    end
  end

  describe Cb::Models::Application::Answer do
    let(:answer_stub) { response_stub['QuestionList'].last['Answers'].first }

    context 'when the response json is well-formed' do
      it 'initializes without issue' do
        Cb::Models::Application::Answer.new(answer_stub)
      end

      it 'parses fields correctly' do
        answer = Cb::Models::Application::Answer.new(answer_stub)
        expect(answer.answer_id).to eq 'Yes'
        expect(answer.answer_text).to eq 'Yes'
        expect(answer.question_id).to eq 'MeetsRequirements'
      end
    end
  end
end
