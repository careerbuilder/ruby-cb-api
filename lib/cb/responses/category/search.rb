require 'cb/responses/api_response'

module Cb
  module Responses
    module Category
      class Search < ApiResponse

        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
          required_response_field(response_node, response)
          required_response_field(categories_node, response[response_node])
          required_response_field(category_node, response[response_node][categories_node])
        end

        def extract_models
          model_array.map { |category| Cb::Models::Category.new(category) }
        end

        private

        def response_node
          "ResponseCategories"
        end

        def categories_node
          "Categories"
        end

        def category_node
          "Category"
        end

        def model_array
          response[response_node][categories_node][category_node]
        end
      end
    end
  end
end
