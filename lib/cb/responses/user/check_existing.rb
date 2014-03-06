module Cb
  module Responses
    module User

      class CheckExisting < ApiResponse
        class Model < Struct.new(:email, :status, :external_id, :oauth_token, :partner_id) ; end

        protected

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(request_node, response[root_node])
          required_response_field(email_node, response[root_node][request_node])
          required_response_field(user_check_status_node, response[root_node])
        end

        def extract_models
          model = Model.new
          model.email = response[root_node][request_node][email_node]
          model.status = response[root_node][user_check_status_node]
          model.external_id = response[root_node][external_id_node]
          model.oauth_token = response[root_node][oauth_token_node]
          model.partner_id = response[root_node][partner_id_node]
          model
        end

        def metadata_containing_node
          response[root_node]
        end

        def hash_containing_metadata
          response
        end

        private

        def root_node
          'ResponseUserCheck'
        end

        def request_node
          'Request'
        end

        def email_node
          'Email'
        end

        def user_check_status_node
          'UserCheckStatus'
        end

        def external_id_node
          'ResponseExternalID'
        end

        def oauth_token_node
          'ResponseOAuthToken'
        end

        def partner_id_node
          'ResponsePartnerID'
        end

      end

    end
  end
end
