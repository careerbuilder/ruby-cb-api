# Copyright 2016 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
module Cb
  module Models
    class Application < ApiResponseModel
      attr_accessor :resume, :is_submitted, :vid, :bid, :sid, :site_id, :ipath_id, :application_did, :cover_letter,
                    :responses, :tn_did, :external_user_id, :redirect_url

      protected

      def required_fields
        %w(Resume IsSubmitted BID ApplicationDID CoverLetter Responses)
      end

      def set_model_properties
        @resume = extract_resume
        @is_submitted = api_response['IsSubmitted'].to_s == 'true'
        @vid = api_response['VID']
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
