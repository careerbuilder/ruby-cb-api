require_relative 'resume_data_list'

module Cb
  module Responses
    class ResumeEducation < ResumeDataListResponse
      def extract_models
        model_hash.map! { |list_item| Models::DataLists::ResumeEducation.new(list_item) }
      end
    end
  end
end
