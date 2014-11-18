require_relative 'resume_data_list'

module Cb
  module Responses
    class EducationCodes < ResumeDataList
      def extract_models
        model_hash.map! { |list_item| Models::DataLists::EducationCode.new(list_item) }
      end
    end
  end
end
