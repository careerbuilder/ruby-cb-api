module Cb
  module Models
    class Application < ApiResponseModel
      attr_accessor :resume, :is_submitted, :bid, :sid, :site_id, :ipath_id, :application_did, :cover_letter,
                    :responses, :tn_did, :external_user_id, :redirect_url

      protected

      def required_fields
        %w(Resume IsSubmitted BID ApplicationDID CoverLetter Responses)
      end

      def set_model_properties
        @resume = extract_resume
        @is_submitted = api_response['IsSubmitted'].to_s == 'true'
        @bid = api_response['BID']
        @sid = api_response['SID']
        @site_id = api_response['SiteID']
        @ipath_id = api_response['IPathID']
        @application_did = api_response['ApplicationDID']
        @cover_letter = extract_cover_letter
        @responses = extract_responses
        @tn_did = api_response['TNDID']
        @external_user_id = api_response['ExternalUserID']
        @redirect_url = api_response['redirectURL']
      end

      private

      def extract_resume
        Resume.new api_response['Resume']
      end

      def extract_cover_letter
        CoverLetter.new api_response['CoverLetter']
      end

      def extract_responses
        api_response['Responses'].map do |response_hash|
          Response.new response_hash
        end
      end

    end
  end
end
