module Cb
  module Responses
    module Industry

      class Search < ApiResponse

        protected

        def extract_models
          extracted_industries_data.map { |indy| Models::Industry.new(indy) }
        end

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(outer_collection_node, response[root_node])
          required_response_field(inner_collection_node, industry_data)
        end

        def hash_containing_metadata
          response[root_node]
        end

        private

        def root_node
          'ResponseIndustryCodes'
        end

        def outer_collection_node
          'IndustryCodes'
        end

        def inner_collection_node
          'IndustryCode'
        end

        def industry_data
          response[root_node][outer_collection_node]
        end

        def extracted_industries_data
          Utils::ResponseArrayExtractor.extract(response[root_node], outer_collection_node)
        end

      end
    end
  end
end