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

    let(:mock_resume) { double(Cb::CbResume) }

    before :each do
      mock_resume.stub(:external_resume_id).and_return('xrid')
      mock_resume.stub(:external_user_id).and_return('xuid')
      mock_resume.stub(:set_attributes)
    end

    context '#retrieve' do
      context 'when pinging the API endpoint' do
        let(:mock_api) { double(Cb::Utils::Api) }

        before :each do
          mock_api.stub(:append_api_responses)
          mock_api.stub(:cb_get).and_return(Hash.new)
          Cb::Utils::Api.stub(:new).and_return(mock_api)
        end

        it 'hits the resume retrieve endpoint' do
          resume_retrieve_endpoint = Cb.configuration.uri_resume_retrieve
          mock_api.should_receive(:cb_get).with(resume_retrieve_endpoint, kind_of(Hash)).and_return(Hash.new)
          Cb::ResumeApi.retrieve(mock_resume)
        end

        it 'includes the user and resume external IDs in the query string' do
          query_hash = { :query =>
            { 'ExternalID' => mock_resume.external_resume_id, 'ExternalUserID' => mock_resume.external_user_id } }

          mock_api.should_receive(:cb_get).with(kind_of(String), query_hash).and_return(Hash.new)
          Cb::ResumeApi.retrieve(mock_resume)
        end

        it 'returns the same resume object that was input' do
          input = mock_resume
          output = Cb::ResumeApi.retrieve(input)
          expect(input.object_id).to eq output.object_id
        end
      end

      context 'when the API call comes back successful' do
        let(:mock_api) { double(Cb::Utils::Api) }

        before :each do
          mock_resume.stub(:set_attributes)
          mock_api.stub(:append_api_responses)
          mock_api.stub(:cb_get).and_return({ 'ResponseRetrieve' => { 'Resume' => Hash.new } })
          Cb::Utils::Api.stub(:new).and_return(mock_api)
        end

        it 'sets new attributes on the input resume based on the result of the API call' do
          mock_resume.should_receive(:set_attributes).with(kind_of(Hash))
          Cb::ResumeApi.retrieve(mock_resume)
        end

        it 'appends generic API responses to the input resume' do
          mock_api.should_receive(:append_api_responses)
          Cb::ResumeApi.retrieve(mock_resume)
        end
      end

      def stub_api_to_return(content)
        stub_request(:get, uri_stem(Cb.configuration.uri_resume_retrieve)).
          to_return(:body => content.to_json)
      end

      def expect_same_resume_no_attributes_set(input)
        output = Cb::ResumeApi.retrieve(input)
        input.should_not have_received(:set_attributes)
        expect(output.object_id).to eq input.object_id
      end

      context 'when nodes are missing from the API responses' do
        context '\ResponseRetrieve' do
          before(:each) { stub_api_to_return(Hash.new) }

          it 'returns the input resume without setting new attributes' do
            expect_same_resume_no_attributes_set(mock_resume)
          end
        end

        context '\ResponseRetrieve\Resume' do
          before(:each) { stub_api_to_return({ ResponseRetrieve: Hash.new }) }

          it 'returns the input resume without setting new attributes' do
            expect_same_resume_no_attributes_set(mock_resume)
          end
        end
      end
    end

    context '#create' do
      before(:each) do
        Cb::ResumeApi.stub(:make_create_xml)
        stub_request(:post, uri_stem(Cb.configuration.uri_resume_create)).
          with(:body => anything).
          to_return(:body => Hash.new.to_json)
      end

      it 'creates the xml API request based off of the input resume' do
        Cb::ResumeApi.should_receive(:make_create_xml)
        Cb::ResumeApi.create(mock_resume)
      end

      it 'posts to the resume create endpoint' do
        mock_api = double(Cb::Utils::Api)
        Cb::Utils::Api.stub(:new).and_return(mock_api)

        resume_create_endpoint = Cb.configuration.uri_resume_create
        mock_api.should_receive(:cb_post).with(resume_create_endpoint, kind_of(Hash))

        Cb::ResumeApi.create(mock_resume)
      end
    end

    context '#update' do
      before(:each) do
        Cb::ResumeApi.stub(:make_update_xml)
        stub_request(:post, uri_stem(Cb.configuration.uri_resume_update)).
          with(:body => anything).
          to_return(:body => Hash.new.to_json)
      end

      it 'creates the xml API request based off of the input resume' do
        Cb::ResumeApi.should_receive(:make_update_xml)
        Cb::ResumeApi.update(mock_resume)
      end

      it 'posts to the resume update endpoint' do
        mock_api = double(Cb::Utils::Api)
        Cb::Utils::Api.stub(:new).and_return(mock_api)

        resume_update_endpoint = Cb.configuration.uri_resume_update
        mock_api.should_receive(:cb_post).with(resume_update_endpoint, kind_of(Hash))

        Cb::ResumeApi.update(mock_resume)
      end
    end

    context '#delete' do
      before(:each) do
        Cb::ResumeApi.stub(:make_delete_xml)
        stub_request(:post, uri_stem(Cb.configuration.uri_resume_delete)).
          with(:body => anything).
          to_return(:body => Hash.new.to_json)
      end

      it 'creates the xml API request based off of the input resume' do
        Cb::ResumeApi.should_receive(:make_delete_xml)
        Cb::ResumeApi.delete(mock_resume)
      end

      it 'posts to the resume delete endpoint' do
        mock_api = double(Cb::Utils::Api)
        Cb::Utils::Api.stub(:new).and_return(mock_api)

        resume_delete_endpoint = Cb.configuration.uri_resume_delete
        mock_api.should_receive(:cb_post).with(resume_delete_endpoint, kind_of(Hash))

        Cb::ResumeApi.delete(mock_resume)
      end
    end

    context 'important private methods' do
      let(:resume) do
        resume = CbResume.new
        resume.external_resume_id = 'xid'
        resume.external_user_id = 'xuid'
        resume.company_experiences = [CbResume::CbCompanyExperience.new]
        resume.educations = [CbResume::CbEducation.new]
        resume.languages = %w(english)
        resume
      end

      context '#make_create_xml' do
        it 'produces valid xml' do
          pending 'this method throws exceptions trying to call methods on resume that do not exist. is this code even used anywhere?'
          xml = Cb::ResumeApi.new.send(:make_create_xml, resume)
          Nokogiri::XML::Document.parse(xml) # if this fails, invalid xml!
        end
      end

      context '#make_update_xml' do
        it 'produces valid xml' do
          pending 'this method throws exceptions trying to call methods on resume that do not exist. is this code even used anywhere?'
          xml = Cb::ResumeApi.new.send(:make_update_xml, resume)
          Nokogiri::XML::Document.parse(xml) # if this fails, invalid xml!
        end
      end

      context '#make_delete_xml' do
        it 'produces valid xml' do
          xml = Cb::ResumeApi.new.send(:make_delete_xml, resume)
          Nokogiri::XML::Document.parse(xml) # if this fails, invalid xml!
        end
      end
    end

  end
end
