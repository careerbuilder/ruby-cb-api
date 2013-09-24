require 'spec_helper'

module Cb
  describe Cb::SpotApi do

    describe '#retrieve' do
      before :each do
        @criteria = Cb::SpotRetrieveCriteria.new
        @criteria.maxitems      = 5
        @criteria.language      = 'WMEnglish'
        @criteria.sortdirection = 'Descending'
        @criteria.sortfield     = 'StartDT'
        @criteria.contenttype   = 'ArticleMgt:WMArticles2'
      end

      it 'returns an array of Cb::Spot models', :vcr => { :cassette_name => 'spot/retrieve' } do
        models = Cb::SpotApi.retrieve @criteria

        models.should be_a Array
        models.first.should be_a Cb::Spot
      end
    end

  end
end
