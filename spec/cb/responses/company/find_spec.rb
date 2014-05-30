
require 'spec_helper'

module Cb
  describe Responses::Company::Find do
    let(:json_hash) do
      {
        "Results" => {
          "CompanyProfileDetail" => {
            "CompanyName"=>"Accountemps",
            "CompanyDID"=>"CHT6P575L7RY61K1NPT",
            "HHName"=>"AccountempsOct1",
            "URL"=>"http://www.accountemps.com",
            "ImageFile"=>nil,
            "YearFounded"=>nil,
            "FBPageURL"=>nil,
            "CompanySize"=>"5,000 - 10,000",
            "CompanyType"=>"Public",
            "HeaderImage"=>nil,
            "FooterImage"=>nil,
            "TotalNumberJobs"=>"2294",
            "Headquarter"=>nil,
            "TabHeaderBGColor"=>nil,
            "TabHeaderTextColor"=>nil,
            "TabHeaderHoverColor"=>nil,
            "SidebarHeaderColor"=>nil,
            "ButtonColor"=>nil,
            "ButtonTextColor"=>nil,
            "GutterBGColor"=>nil,
            "FacebookWidget"=>nil,
            "TwitterWidget"=>nil,
            "LinkedInWidget"=>nil,
            "HostSites"=>nil,
            "SDrive"=>nil,
            "CompanyPhotos"=>{"PhotoList"=>nil},
            "CompanyAddress"=>{"AddressList"=>nil},
            "CompanyBulletinBoard"=>{"bulletinboards"=>nil},
            "Testimonials"=>{"Testimonials"=>nil},
            "MyContent"=>{"MyContentTabs"=>nil},
            "MyPhotos"=>nil,
            "InfoTabs"=>
             {"InfoTabs"=>
                {"InfoTab"=>
                   [{"Name"=>"Products",
                     "Content"=> ""
                    },
                   {"Name"=>"Contact Us",
                    "Content"=> ""}]}},
            "CompanyLinksCollection"=>{"companylinks"=>nil},
            "CollegeLabel"=>"College",
            "CollegeBody"=>nil,
            "DiversityLabel"=>"Diversity",
            "DiversityBody"=>nil,
            "PeopleLabel"=>"People",
            "ContactLabel"=>"Contact",
            "isEnhance"=>"false",
            "MilitaryIcon"=>"false",
            "PremiumProfile"=>"true",
            "HasBenefits"=>"false",
            "HasGallery"=>"false",
            "HasSocialMedia"=>"false",
            "HasVideo"=>"false",
            "IndustryType"=>{"string"=>"Accounting - Finance"}}
        }
      }
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        Responses::Company::Find.new(json_hash).class.should eq Responses::Company::Find
      end

      it 'instantiates new model objects' do
        response = Responses::Company::Find.new(json_hash)

        response.model.class.should == Cb::Models::Company
      end

    end
  end
end