module Cb
  module Models
    class Application

      class Form < ApiResponseModel
        attr_reader :job_did, :job_title, :is_shared_apply, :question_list, :requirements,
                    :degree_required, :travel_required, :experience_required, :external_application,
                    :total_questions, :total_required_questions

        protected

        def required_fields
          %w(
            JobDID JobTitle IsSharedApply QuestionList Requirements DegreeRequired TravelRequired
            ExperienceRequired ExternalApplication TotalQuestions TotalRequiredQuestions
          )
        end

        def set_model_properties
          @job_did                  = api_response['JobDID']
          @job_title                = api_response['JobTitle']
          @is_shared_apply          = api_response['IsSharedApply']
          @requirements             = api_response['Requirements']
          @degree_required          = api_response['DegreeRequired']
          @travel_required          = api_response['TravelRequired']
          @total_questions          = api_response['TotalQuestions'].to_i
          @total_required_questions = api_response['TotalRequiredQuestions'].to_i
          @experience_required      = api_response['ExperienceRequired']
          @external_application     = api_response['ExternalApplication']
          @question_list            = api_response['QuestionList'].map { |question_hash| Question.new(question_hash) }
        end
      end

      class Question < ApiResponseModel
        attr_reader :expected_response_format, :is_required, :question_id, :question_text, :question_type, :answers

        protected

        def required_fields
          %w(ExpectedResponseFormat IsRequired QuestionID QuestionText QuestionType Answers)
        end

        def set_model_properties
          @is_required   = api_response['IsRequired']
          @question_id   = api_response['QuestionID']
          @question_text = api_response['QuestionText']
          @question_type = api_response['QuestionType']
          @answers       = api_response['Answers'].map { |answer_hash| Answer.new(answer_hash) }
          @expected_response_format = api_response['ExpectedResponseFormat']
        end
      end

      class Answer < ApiResponseModel
        attr_reader :answer_id, :answer_text, :question_id

        protected

        def required_fields
          %w(AnswerID AnswerText QuestionID)
        end

        def set_model_properties
          @answer_id   = api_response['AnswerID']
          @answer_text = api_response['AnswerText']
          @question_id = api_response['QuestionID']
        end
      end

    end
  end
end
