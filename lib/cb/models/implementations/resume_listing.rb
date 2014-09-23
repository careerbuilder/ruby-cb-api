module Cb
  module Models
    class ResumeListing < ApiResponseModel
      attr_accessor :title, :external_id, :host_site, :modified_dt, :visibility

      def set_model_properties
        @title = api_response['Title']
        @external_id = api_response['ExternalID']
        @host_site = api_response['HostSite']
        @modified_dt = api_response['ModifiedDT']
        @visibility = api_response['Visibility']
      end

      def required_fields
        ['Title', 'ExternalID', 'Visibility']
      end
    end
  end
end