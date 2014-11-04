module Cb
  module Responses
    module Resumes
      class LanguageCodes < ApiResponse
        protected
        def validate_api_hash
          required_response_field(collection_node, response[root_node])
        end

        def hash_containing_metadata
          response[root_node]
        end

        def extract_models
          model_hash.map { |language_code| Models::Resumes::LanguageCode.new(language_code) }
        end

        private

        def root_node
          'ResponseLanguageCodes'
        end

        def collection_node
          'LanguageCodes'
        end

        def model_hash
          response[root_node][collection_node]['LanguageCode']
        end
      end
    end
  end
end
