# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'json'

module Mocks
  class SavedSearch
    class << self
      def list
        JSON.parse '{
          "TotalResults":4,
          "ReturnedResults":4,
          "Results":[
          {
            "DID":"JRDID1",
            "SearchName":"asearchname1",
            "HostSite":"US",
            "SiteID":"asiteid1",
            "Cobrand":"acobrand1",
            "IsDailyEmail":"false",
            "EmailDeliveryDay":"NONE",
            "JobSearchUrl":"ajobsearchurl1",
            "SavedSearchParameters":{
              "BooleanOperator":"AND",
              "Category":"",
              "EducationCode":"DRNS",
              "EmpType":"",
              "ExcludeCompanyNames":"",
              "ExcludeJobTitles":"",
              "ExcludeKeywords":"",
              "ExcludeNational":false,
              "IndustryCodes":"",
              "JobTitle":"",
              "Keywords":"sales",
              "Location":"Norcross, GA",
              "OrderBy":"Distance",
              "OrderDirection":"descending",
              "PayHigh":0,
              "PayInfoOnly":false,
              "PayLow":0,
              "PostedWithin":30,
              "Radius":10,
              "SpecificEducation":false,
              "JCPositionLevel":"",
              "JCLocation":"",
              "JCAdvertiserFlags":"",
              "JCJobNature":"",
              "Company":"",
              "City":"",
              "State":"",
              "Country":""
            }
          },
          {
            "DID":"JRDID2",
            "SearchName":"asearchname2",
            "HostSite":"SG",
            "SiteID":"asiteid2",
            "Cobrand":"acobrand2",
            "IsDailyEmail":"true",
            "EmailDeliveryDay":"NONE",
            "JobSearchUrl":"ajobsearchurl2",
            "SavedSearchParameters":{
              "BooleanOperator":"AND",
              "Category":"",
              "EducationCode":"DRNS",
              "EmpType":"",
              "ExcludeCompanyNames":"",
              "ExcludeJobTitles":"",
              "ExcludeKeywords":"",
              "ExcludeNational":false,
              "IndustryCodes":"",
              "JobTitle":"",
              "Keywords":"Sales",
              "Location":"",
              "OrderBy":"",
              "OrderDirection":"ascending",
              "PayHigh":99999,
              "PayInfoOnly":false,
              "PayLow":99999,
              "PostedWithin":30,
              "Radius":30,
              "SpecificEducation":false,
              "JCPositionLevel":"",
              "JCLocation":"",
              "JCAdvertiserFlags":"",
              "JCJobNature":"",
              "Company":"",
              "City":"NORCROSS",
              "State":"GA",
              "Country":""
            }
          }
          ],
          "Errors":[
          ],
          "Timestamp":"2014-03-18T14:02:53.3150101-04:00",
          "Status":"Success"
        }'
      end

      def empty_list
        JSON.parse '{
          "TotalResults":0,
          "ReturnedResults":0,
          "Results":[],
          "Errors":[],
          "Timestamp":"2014-03-18T14:02:53.3150101-04:00",
          "Status":"Success"
        }'
      end

      def create
        JSON.parse '{
          "Errors":[],
          "SavedJobFields":{
            "DID":"asavedjobdid",
            "JobDID":"ajobdid",
            "JobTitle":"ajobtitle",
            "CompanyName":"acompanyname",
            "CompanyDID":"acompanydid",
            "Location":"US-ST-CTY",
            "DateExpires":"\/Date(18000000)\/",
            "DateSaved":"\/Date(18000000)\/",
            "DateApplied":"\/Date(18000000)\/",
            "Status":"Saved",
            "HasApplied":false,
            "Notes":"anote"
          }
        }'
      end

      def delete
        JSON.parse '{
          "Errors":[],
          "WasSuccessful":true
        }'
      end
    end
  end
end
