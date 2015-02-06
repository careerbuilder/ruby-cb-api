require 'spec_helper'
module Cb
  describe Responses::AnonymousSavedSearch::Create do
    let(:json_hash) do
      {
        "Errors" => [],
        "Status" => "Success",
        "ExternalID" => "testID",
        "AnonymousSavedSearch" => {
          "SearchName" => "search name",
          "IsDailyEmail" => "true",
          "DailyValue" => "",
          "EmailAddress" => "email@example.com",
          "CobrandCode" => "",
          "SiteID" => "",
          "HostSite" => "host site",
          "SearchParameters" => {
            "BooleanOperator" => "boolean operator",
            "Category" => "",
            "EducationCode" => "education code",
            "EmpType" => "emp type",
            "ExcludeCompanyNames" => "exclude company names",
            "ExcludeJobTitles" => "exclude job titles",
            "ExcludeKeywords" => "exclude keywords",
            "ExcludeNational" => false,
            "IndustryCodes" => "industry codes",
            "JobTitle" => "job title",
            "Keywords" => "jobs",
            "Location" => "atlanta",
            "OrderBy" => "order by",
            "OrderDirection" => "order direction",
            "PayHigh" => 100,
            "PayInfoOnly" => false,
            "PayLow" => 10,
            "PostedWithin" => 3,
            "Radius" => 50,
            "SpecificEducation" => false,
            "JCPositionLevel" => "",
            "JCLocation" => "",
            "JCAdvertiserflags" => "",
            "JCJobNature" => "",
            "JCSchools" => "",
            "JobCategory" => "job category",
            "Company" => "",
            "City" => "",
            "State" => "",
            "Country" => nil
          }
        }
      }
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        expect(Responses::AnonymousSavedSearch::Create.new(json_hash).class).to eq Responses::AnonymousSavedSearch::Create
      end

      it 'instantiates new model objects' do
        response = Responses::AnonymousSavedSearch::Create.new(json_hash)

        expect(response.model.class).to eq(Cb::Models::SavedSearch)
      end

    end
  end
end