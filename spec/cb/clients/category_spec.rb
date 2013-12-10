require 'spec_helper'

module Cb
  describe Cb::Clients::Category do
    
    def stub_api_call_to_return(content_to_return)
      stub_request(:get, uri_stem(Cb.configuration.uri_job_category_search)).
        to_return(:body => content_to_return.to_json)
    end

    def assert_empty_array(api_client_result)
      expect(api_client_result).to be_an_instance_of Array
      expect(api_client_result.empty?).to eq true
    end

    def assert_array_of_models(api_client_result)
      expect(api_client_result).to be_an_instance_of(Array)
      expect(api_client_result.size).to eq 1
      expect(api_client_result.first).to be_an_instance_of(Cb::CbCategory)
    end
    
    context '.new' do
      it 'should create a new category api project' do
        category_api = Cb::Clients::Category.new
        category_api.is_a?(Cb::Clients::Category).should == true
      end
    end

    context '.search' do
      context 'when API response hash has all required fields' do
        before(:each) do
          stub_api_call_to_return({ResponseCategories: {Categories: {Category: [{Code: 'doodad', Name: 'things', Language: 'wut'}]}}})
        end

        it 'returns an Array of category models' do
          assert_array_of_models(Cb.category.search)
        end
      end

      context 'when the API response has' do
        context 'missing fields' do

          context '\ResponseCategories' do
            before(:each) { stub_api_call_to_return(Hash.new) }

            it 'returns an empty Array' do
              assert_empty_array(Cb.category.search)
            end
          end

          context '\ResponseCategories\Categories' do
            before(:each) { stub_api_call_to_return({ ResponseCategories: Hash.new })}

            it 'returns an empty Array' do
              assert_empty_array(Cb.category.search)
            end
          end

          context '\ResponseCategories\Categories\Category' do
            before(:each) { stub_api_call_to_return({ ResponseCategories: { Categories: Hash.new } })}

            it 'raises a NoMethodError' do
              expect { Cb.category.search }.to raise_error NoMethodError
            end
          end
        end

        context 'fields that are the wrong type:' do
          context '\ResponseCategories\Categories\Category does not respond to #each' do
            before :each do
              stub_api_call_to_return({ ResponseCategories: { Categories: { Category: String.new } } })
            end

            it 'raises a NoMethodError when #each is attempted' do
              expect { Cb.category.search }.to raise_error NoMethodError
            end
          end
        end
      end

    end # .search

    context '.search_by_host_site' do
      context 'when API response hash has all required fields' do
        context 'and \ResponseCategories\Categories\Category is an array' do
          before(:each) do
            stub_api_call_to_return({ResponseCategories: {Categories: {Category: [{Code: 'doodad', Name: 'things', Language: 'wut'}]}}})
          end

          it 'returns an Array of category models' do
            assert_array_of_models(Cb.category.search_by_host_site('WM'))
          end
        end

        context 'and \ResponseCategories\Categories\Category is a hash (i.e. single category returned' do
          before(:each) do
            stub_api_call_to_return({ResponseCategories: {Categories: {Category: {Code: 'doodad', Name: 'things', Language: 'wut'}}}})
          end

          it 'returns an Array of category models' do
            assert_array_of_models(Cb.category.search_by_host_site('WM'))
          end
        end
      end

      context 'when the API response has' do
        context 'missing fields' do

          context '\ResponseCategories' do
            before(:each) { stub_api_call_to_return(Hash.new) }

            it 'returns an empty Array' do
              assert_empty_array(Cb.category.search_by_host_site('WM'))
            end
          end

          context '\ResponseCategories\Categories' do
            before(:each) { stub_api_call_to_return({ ResponseCategories: Hash.new }) }

            it 'returns an empty Array' do
              assert_empty_array(Cb.category.search_by_host_site('WM'))
            end
          end

          context '\ResponseCategories\Categories\Category' do
            before(:each) { stub_api_call_to_return({ ResponseCategories: { Categories: Hash.new } })}

            it 'returns an empty array' do
              assert_empty_array(Cb.category.search_by_host_site('WM'))
            end
          end
        end

        context 'fields that are the wrong type:' do
          context '\ResponseCategories\Categories\Category is not an array or hash' do
            before :each do
              stub_api_call_to_return({ ResponseCategories: { Categories: { Category: String.new } } })
            end

            it 'returns an empty array' do
              assert_empty_array(Cb.category.search_by_host_site('WM'))
            end
          end
        end
      end

    end # .search_by_host_site

  end
end
