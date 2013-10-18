require 'spec_helper'

module Cb
  describe Cb::ResumeApi do

    context '#own_all' do
      context 'when pinging the API' do
        let(:api) { double(Cb::Utils::Api) }

        before :each do
          api.stub(:cb_get)
          Cb::Utils::Api.stub(:new).and_return(api)
        end

        it 'hits the resume own all endpoint' do
          endpoint_url = Cb.configuration.uri_resume_own_all
          api.should_receive(:cb_get).with(endpoint_url, kind_of(Hash)).and_return(Hash.new)
          Cb::ResumeApi.own_all('xid')
        end

        it 'includes external user ID in the query string' do
          query = { query: { 'ExternalUserID' => 'xid' } }
          api.should_receive(:cb_get).with(kind_of(String), query).and_return(Hash.new)
          Cb::ResumeApi.own_all('xid')
        end

        context 'and ignore_host_site optional param is true' do
          it 'includes hostsite ignore flag in the query string' do
            query = { query: { 'ExternalUserID' => 'xid', 'IgnoreHostSite' => 'true' } }
            api.should_receive(:cb_get).with(kind_of(String), query).and_return(Hash.new)
            Cb::ResumeApi.own_all('xid', true)
          end
        end
      end

      def stub_api_to_return(content)
        stub_request(:get, uri_stem(Cb.configuration.uri_resume_own_all)).
          to_return(:body => content.to_json)
      end

      context 'when the returned API hash has all required fields' do
        before :each do
          stub_api_to_return({ ResponseOwnResumes: { Resumes: { Resume: [Hash.new] } } })
        end

        it 'returns an array of resume models' do
          models = Cb::ResumeApi.own_all('xid')
          expect(models).to be_an_instance_of Array
          expect(models.first).to be_an_instance_of Cb::CbResume
        end
      end

      context 'when the returned API hash does not contain required fields' do
        context '\ResponseOwnResumes' do
          before(:each) { stub_api_to_return(Hash.new) }

          it 'returns an empty array' do
            models = Cb::ResumeApi.own_all('xid')
            expect(models).to be_an_instance_of Array
            expect(models.empty?).to eq true
          end
        end

        context '\ResponseOwnResumes\Resumes' do
          before(:each) { stub_api_to_return({ ResponseOwnResumes: Hash.new }) }

          it 'returns an empty array' do
            models = Cb::ResumeApi.own_all('xid')
            expect(models).to be_an_instance_of Array
            expect(models.empty?).to eq true
          end
        end

        context '\ResponseOwnResumes\Resumes\Resume' do
          before(:each) { stub_api_to_return({ ResponseOwnResumes: { Resumes: Hash.new } }) }

          it 'raises NoMethodError when #each is attempted on the missing enumerable node' do
            expect { Cb::ResumeApi.own_all('xid') }.to raise_error NoMethodError
          end
        end
      end
    end # .own_all

    context '#retrieve_by_id' do
      # this method is full of lolz, and should be what #retrieve calls instead of copying all of that code.
      # also, the way it's currently written i'm pretty sure it won't work at all.
    end

    context '#retrieve' do
      context 'when pinging the API endpoint' do
        it 'hits the resume retrieve endpoint'

        it 'includes the user and resume external IDs in the query string'
      end

      context 'when the API call comes back successful' do
        it 'returns the same resume object that was input'

        it 'sets new attributes on the input resume based on the result of the API call'

        it 'appends generic API responses to the input resume'
      end

      context 'when nodes are missing from the API responses' do
        context '\ResponseRetrieve' do
          it 'returns the input resume without setting new attributes'
        end

        context '\ResponseRetrieve\Resume' do
          it 'returns the input resume without setting new attributes'
        end
      end
    end

    let(:resume) do
      nil # this needs to be a fully fleshed out resume model :(
    end

    context '#create' do
      it 'creates the xml API request based off of the input resume'

      it 'posts the resume xml to the resume create endpoint'
    end

    context '#update' do
      it 'creates the xml API request based off of the input resume'

      it 'posts the resume xml to the resume update endpoint'
    end

    context '#delete' do
      it 'creates the xml API request based off of the input resume'

      it 'posts the resume xml to the resume delete endpoint'
    end

  end
end
