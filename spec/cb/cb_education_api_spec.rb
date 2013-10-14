require 'spec_helper'

module Cb
  describe Cb::EducationApi do
    def stub_api_to_return(content)
      stub_request(:get, uri_stem(Cb.configuration.uri_education_code)).
        to_return(:body => content.to_json)
    end

    context '.get_for' do
      it 'calls #append_api_responses on the Cb API utility client'
      it 'pings the API with countrycode in the query string'

      context 'when the API response has all required nodes' do
        it 'returns and array of education models'
      end

      context 'when the API response is missing nodes' do
        it '\ResponseEducationCodes missing, returns an empty array'
        it '\ResponseEducationCodes\EducationCodes, returns an empty array'
        it '\ResponseEducationCodes\EducationCodes\Education, raises a NoMethodError when #each is attempted'
      end

    end
  end
end