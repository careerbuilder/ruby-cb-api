require 'spec_helper'

module Cb
  describe Cb::CategoryApi do
    context ".new" do
      it "should create a new category api project" do
        VCR.use_cassette('Category API Object') do
          category_api = Cb::CategoryApi.new()
          category_api.is_a?(Cb::CategoryApi).should == true
        end
      end
    end

    context ".search" do
      it "should retrieve search result for default category code" do
        VCR.use_cassette('Category API Search Result') do
          result = Cb.category.search()
          result.each do |res|
            res.name.should_not be_empty
            res.code.should_not be_empty
          end
          result.api_error.should == false
        end
      end

      it 'should set api error on bogus request', :vcr => { :cassette_name => 'category/search_bogus_request' } do
        correct_url = Cb.configuration.uri_job_category_search

        Cb.configuration.uri_job_category_search = Cb.configuration.uri_job_category_search + 'a'
        result = Cb.category.search()
        Cb.configuration.uri_job_category_search = correct_url

        result.empty?.should be_true
        result.api_error.should == true
      end
    end

    context ".search_by_host_site" do
      it "should get a list of categories for the specific hostsite" do
        VCR.use_cassette('Host Site Categories') do

          # you may choose any host site. The api defines this parameter as                       #
          # a country code. It should really be host site because different sites have different  #
          # categories.                                                                           #
          # For more information about this function, visit api.careerbuilder.com                 #

          result = Cb.category.search_by_host_site('WM')
          result.each do |res|
            res.name.should_not be_empty
            res.code.should_not be_empty
          end
          result.api_error.should == false
        end
      end


      it 'should set api error on bogus request', :vcr => { :cassette_name => 'catergory/site_bogus_request'} do
        correct_url = Cb.configuration.uri_job_category_search

        Cb.configuration.uri_job_category_search = Cb.configuration.uri_job_category_search + 'a'
        result = Cb.category.search_by_host_site('WM')
        Cb.configuration.uri_job_category_search = correct_url

        result.empty?.should be_true
        result.api_error.should == true
      end
    end
  end
end
