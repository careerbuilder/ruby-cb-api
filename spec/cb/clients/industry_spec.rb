require 'spec_helper'

module Cb
  describe Cb::Clients::Industry do

    def stub_api_call_to_return(content_to_return)
      stub_request(:get, uri_stem(Cb.configuration.uri_job_industry_search)).
        to_return(:body => content_to_return.to_json)
    end

    def assert_empty_array(api_client_result)
      expect(api_client_result).to be_an_instance_of Array
      expect(api_client_result.empty?).to eq true
    end

    def assert_array_of_models(api_client_result)
      expect(api_client_result).to be_an_instance_of(Array)
      expect(api_client_result.size).to eq 1
      expect(api_client_result.first).to be_an_instance_of(Cb::Models::Industry)
    end

    context '.new' do
      it 'should create a new industry api project' do
        industry_api = Cb::Clients::Industry.new
        industry_api.is_a?(Cb::Clients::Industry).should == true
      end
    end

    context '.search' do
      context 'when API response hash has all required fields' do
        before(:each) do
          stub_api_call_to_return({ResponseIndustryCodes: {IndustryCodes: {IndustryCode: [{Code: 'doodad', Name: 'things', Language: 'wut'}]}}})
        end

        it 'returns an Array of industry models' do
          assert_array_of_models(Cb.industry.search)
        end
      end

      context 'when the API response has' do
        context 'missing fields' do

          context '\ResponseIndustryCodes' do
            before(:each) { stub_api_call_to_return(Hash.new) }

            it 'returns an empty Array' do
              assert_empty_array(Cb.industry.search)
            end
          end

          context '\ResponseIndustryCodes\IndustryCodes' do
            before(:each) { stub_api_call_to_return({ ResponseIndustryCodes: Hash.new })}

            it 'returns an empty Array' do
              assert_empty_array(Cb.industry.search)
            end
          end

          context '\ResponseIndustryCodes\IndustryCodes\Industry' do
            before(:each) { stub_api_call_to_return({ ResponseIndustryCodes: { IndustryCodes: Hash.new } })}

            it 'raises a NoMethodError' do
              expect { Cb.industry.search }.to raise_error NoMethodError
            end
          end
        end

        context 'fields that are the wrong type:' do
          context '\ResponseIndustryCodes\IndustryCodes\Industry does not respond to #each' do
            before :each do
              stub_api_call_to_return({ ResponseIndustryCodes: { IndustryCodes: { IndustryCode: String.new } } })
            end

            it 'raises a NoMethodError when #each is attempted' do
              expect { Cb.industry.search }.to raise_error NoMethodError
            end
          end
        end
      end

    end # .search

    context '.search_by_host_site' do
      context 'when API response hash has all required fields' do
        context 'and \ResponseIndustryCodes\IndustryCodes\Industry is an array' do
          before(:each) do
            stub_api_call_to_return({ResponseIndustryCodes: {IndustryCodes: {IndustryCode: [{Code: 'doodad', Name: 'things', Language: 'wut'}]}}})
          end

          it 'returns an Array of industry models' do
            assert_array_of_models(Cb.industry.search_by_host_site('WM'))
          end
        end

        context 'and \ResponseIndustryCodes\IndustryCodes\Industry is a hash (i.e. single industry returned' do
          before(:each) do
            stub_api_call_to_return({ResponseIndustryCodes: {IndustryCodes: {IndustryCode: {Code: 'doodad', Name: 'things', Language: 'wut'}}}})
          end

          it 'returns an Array of industry models' do
            assert_array_of_models(Cb.industry.search_by_host_site('WM'))
          end
        end
      end

      context 'when the API response has' do
        context 'missing fields' do

          context '\ResponseIndustryCodes' do
            before(:each) { stub_api_call_to_return(Hash.new) }

            it 'returns an empty Array' do
              assert_empty_array(Cb.industry.search_by_host_site('WM'))
            end
          end

          context '\ResponseIndustryCodes\IndustryCodes' do
            before(:each) { stub_api_call_to_return({ ResponseIndustry: Hash.new }) }

            it 'returns an empty Array' do
              assert_empty_array(Cb.industry.search_by_host_site('WM'))
            end
          end

          context '\ResponseIndustryCodes\IndustryCodes\Industry' do
            before(:each) { stub_api_call_to_return({ ResponseIndustryCodes: { IndustryCodes: Hash.new } })}

            it 'returns an empty array' do
              assert_empty_array(Cb.industry.search_by_host_site('WM'))
            end
          end
        end

        context 'fields that are the wrong type:' do
          context '\ResponseIndustryCodes\IndustryCodes\Industry is not an array or hash' do
            before :each do
              stub_api_call_to_return({ ResponseIndustryCodes: { IndustryCodes: { IndustryCode: String.new } } })
            end

            it 'returns an empty array' do
              assert_empty_array(Cb.industry.search_by_host_site('WM'))
            end
          end
        end
      end

    end # .search_by_host_site

  end
end
