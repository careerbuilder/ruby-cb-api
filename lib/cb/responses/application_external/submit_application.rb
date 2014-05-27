require 'cb/responses/api_response'

module Cb
  module Responses
    module ApplicationExternal
      class SubmitApplication < ApiResponse

        class Model < Struct.new(:errors, :apply_url) ; end

        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
        end

        def extract_models
          model = Model.new
          model.errors = response[errors]
          model.apply_url = response[apply_url]
          model
        end

        private

        def errors
          'Errors'
        end

        def apply_url
          'ApplyUrl'
        end
      end
    end
  end
end
