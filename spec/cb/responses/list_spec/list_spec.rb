require 'spec_helper'

module Cb
  describe Responses::WorkStatus::List do
    let(:json_hash) do
      {
        "Errors" => nil,
        "WorkStatuses" => [
          {
            "Key" => "CTCT",
            "Description" => [
              {
                "Language" => "French",
                "Value" => "Citoyen"
              },
              {
                "Language" => "Dutch",
                "Value" => "Inwoner"
              },
              {
                "Language" => "English",
                "Value" => "US Citizen"
              }
            ]
          }
        ]
      }
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        Responses::WorkStatus::List.new(json_hash).class.should eq Responses::WorkStatus::List
      end

      it 'instantiates new model objects' do
        models = Responses::WorkStatus::List.new(json_hash).models

        models[0].class.should == Cb::Models::WorkStatus

        models.length.should == 1

        models[0].key.should == 'CTCT'

        translations = models[0].translations

        translations[0].class.should == Cb::Models::WorkStatus::Translation
        translations[1].class.should == Cb::Models::WorkStatus::Translation
        translations[2].class.should == Cb::Models::WorkStatus::Translation

        translations.length.should == 3

        translations[0].language.should == 'French'
        translations[0].value.should == 'Citoyen'

        translations[1].language.should == 'Dutch'
        translations[1].value.should == 'Inwoner'

        translations[2].language.should == 'English'
        translations[2].value.should == 'US Citizen'
      end

    end
  end
end
