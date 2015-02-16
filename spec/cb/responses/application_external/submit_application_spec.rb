require 'spec_helper'

module Cb
  describe Responses::ApplicationExternal::SubmitApplication do
    let(:json_hash) do
      { 'Errors' => nil,
        'ApplyUrl' => "website.com"
      }
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        expect(Responses::ApplicationExternal::SubmitApplication.new(json_hash).class).to eq Responses::ApplicationExternal::SubmitApplication
      end

      it 'instantiates new model objects' do
        response = Responses::ApplicationExternal::SubmitApplication.new(json_hash)

        expect(response.model.apply_url).to eq("website.com")
      end

    end
  end
end