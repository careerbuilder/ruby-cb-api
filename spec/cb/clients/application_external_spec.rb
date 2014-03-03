require 'spec_helper'


module Cb
  describe Cb::Clients::ApplicationExternal do

    context '#submit_app' do

      context 'when the parameter not the correct type' do
        it 'should raise a Cb::IncomingParamIsWrongTypeException' do
          expect { Cb.application_external.submit_app(Object.new) }.to raise_error Cb::IncomingParamIsWrongTypeException
        end
      end

      def stub_api_call_to_return(body_content)
        stub_request(:post, uri_stem(Cb.configuration.uri_application_external)).with(:body => anything).
          to_return(:body => body_content.to_json)
      end

      def submit_app(app)
        Cb::Clients::ApplicationExternal.submit_app(app)
      end

      context 'when everything is working correctly' do
        let(:external_app) { Cb::Models::ApplicationExternal.new({job_did: 'did', email: 'bogus@bogus.org', ipath: 'bogus', site_id: 'bogus'}) }

        it 'the same application object is returned that is supplied for input' do
          stub_api_call_to_return(Hash.new)
          app = submit_app(external_app)
          app.should eq external_app
          app.object_id.should eq external_app.object_id
        end

        context 'if the ApplyUrl field comes back in the response' do
          before(:each) { stub_api_call_to_return({'ApplyUrl' => 'https://bacondreamz.net'}) }

          it 'the ApplyUrl is set on the returned app' do
            app = submit_app(external_app)
            app.apply_url.should eq 'https://bacondreamz.net'
          end
        end

        context 'if the ApplyUrl field is not in the response' do
          before(:each) { stub_api_call_to_return(Hash.new) }

          it 'the ApplyUrl on the returned app is blank' do
            app = submit_app(external_app)
            app.apply_url.empty?.should eq true
          end
        end

        context 'when posting to the API' do
          before(:each) do
            @mock_api = double(Cb::Utils::Api)
            @mock_api.stub(:cb_post)
            @mock_api.stub(:append_api_responses)
            Cb::Utils::Api.stub(:new).and_return @mock_api
          end

          it 'converts the application to xml' do
            @mock_api.should_receive(:cb_post).with(kind_of(String), body: external_app.to_xml).and_return(Hash.new)
            submit_app(external_app)
          end

          it 'posts to the application external API endpoint' do
            @mock_api.should_receive(:cb_post).with(Cb.configuration.uri_application_external, kind_of(Hash)).and_return(Hash.new)
            submit_app(external_app)
          end
        end
      end
    end

  end
end
