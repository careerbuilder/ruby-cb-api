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
          @question_list            = extracted_questions
        end

        def extracted_questions
          questions = extractable_questions? ? response_questions : Array.new
          questions.map { |question_hash| Question.new(question_hash) }
        end

        def extractable_questions?
          !response_questions.nil? && !response_questions.empty? && response_questions.respond_to?(:map)
        end

        def response_questions
          api_response['QuestionList']
        end
      end

      class Question < ApiResponseModel
        attr_reader :expected_response_format, :is_required, :question_id, :question_text,
                    :question_type, :answers, :max_characters, :min_characters

        protected

        def required_fields
          %w(ExpectedResponseFormat IsRequired QuestionID QuestionText QuestionType Answers)
        end

        def set_model_properties
          @is_required    = api_response['IsRequired']
          @question_id    = api_response['QuestionID']
          @question_text  = api_response['QuestionText']
          @question_type  = api_response['QuestionType']
          @answers        = extracted_answers
          @min_characters = extracted_int_or_nil('minCharacters')
          @max_characters = extracted_int_or_nil('maxCharacters')
          @expected_response_format = api_response['ExpectedResponseFormat']
        end

        def extracted_answers
          answers = extractable_answers? ? response_answers : Array.new
          answers.map { |answer_hash| Answer.new(answer_hash) }
        end

        def extractable_answers?
          !response_answers.nil? && !response_answers.empty? && response_answers.respond_to?(:map)
        end

        def response_answers
          api_response['Answers']
        end

        def extracted_int_or_nil(key)
          api_response.has_key?(key) ? api_response[key].to_i : nil
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
