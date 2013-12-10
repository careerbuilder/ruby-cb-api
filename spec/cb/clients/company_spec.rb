require 'spec_helper'

module Cb
  describe Cb::Clients::Company do
    def stub_api_response_to_return(content)
      stub_request(:get, uri_stem(Cb.configuration.uri_company_find)).
        to_return(:body => content.to_json)
    end

    context '.find_by_did' do
      it 'pings the API with company DID and hostsite in the query string' do
        target_did = 'fake-did'
        query_hash = { query: { CompanyDID: target_did, hostsite: Cb.configuration.host_site }}

        cb_api_client = double(Cb::Utils::Api)
        cb_api_client.should_receive(:cb_get).with(Cb.configuration.uri_company_find, query_hash).and_return(Hash.new)
        cb_api_client.stub(:append_api_responses)
        Cb::Utils::Api.stub(:new).and_return(cb_api_client)

        Cb::Clients::Company.find_by_did(target_did)
      end

      context 'when the API response has all required nodes' do
        before(:each) do
          content = { Results: { CompanyProfileDetail: {
            CompanyPhotos: { PhotoList: Array.new },
            CompanyBulletinBoard: { bulletinboards: Hash.new },
            Testimonials: { Testimonials: Array.new },
            CompanyLinksCollection: { companylinks: Array.new },
            MyContent: { MyContentTabs: Array.new },
            InfoTabs: { InfoTabs: Array.new }
          }}}
          stub_api_response_to_return(content)
        end

        it 'returns a single company model' do
          model = Cb::Clients::Company.find_by_did('fake-did')
          expect(model).to be_an_instance_of Cb::CbCompany
        end
      end

      context 'when the API response does not contain the required fields:' do
        before(:each) { stub_api_response_to_return(Hash.new) }

        it '\Results missing, nil is returned' do
          expect(Cb::Clients::Company.find_by_did('fake-did')).to be_nil
        end

        it '\Results\CompanyProfileDetail missing, nil is returned' do
          expect(Cb::Clients::Company.find_by_did('fake-did')).to be_nil
        end
      end
    end # .find_by_did

    context '.find_for' do
      context 'when a string is the input arg' do
        context 'and the input string is empty' do
          it 'does not end up performing the company lookup' do
            Cb::Clients::Company.should_not_receive(:find_by_did)
            Cb::Clients::Company.find_for(String.new)
          end
        end

        context 'and the input string is not empty' do
          it 'calls #find_by_did with the supplied DID' do
            target_did = 'fake-did'
            Cb::Clients::Company.should_receive(:find_by_did).with(target_did)
            Cb::Clients::Company.find_for(target_did)
          end
        end
      end

      context 'when a Cb::CbJob is the input arg' do
        it "calls #find_by_did with the job model's company_did" do
          job_model = Cb::CbJob.new('CompanyDID' => 'fake-did')
          Cb::Clients::Company.should_receive(:find_by_did).with(job_model.company_did)
          Cb::Clients::Company.find_for(job_model)
        end
      end
    end

  end
end
