require 'spec_helper'
module Cb
  describe Responses::AnonymousSavedSearch::Delete do
    let(:json_hash) do
      {
        'Status' => 'yay'
      }
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        expect(Responses::AnonymousSavedSearch::Delete.new(json_hash).class).to eq Responses::AnonymousSavedSearch::Delete
      end

      it 'instantiates new model objects' do
        response = Responses::AnonymousSavedSearch::Delete.new(json_hash)

        expect(response.response["Status"]).to eq('yay')
      end

    end
  end
end