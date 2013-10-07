require 'spec_helper'

module Cb
  describe Cb::ApplicationApi do
    context '#for_job (blank application)' do
      def stub_api_request_to_return(content_to_be_jsonified)
        stub_request(:get, uri_stem(Cb.configuration.uri_application)).
          to_return(:body => content_to_be_jsonified.to_json)
      end

      before :each do
        stub_api_request_to_return({ 'ResponseBlankApplication' => {
          'BlankApplication' => {
            'IsSharedApply' => 'false', 'TotalQuestions' => 1, 'TotalRequiredQuestions' => 1, 'Questions' => {
              'Question' => [{ 'IsRequired' => 'true', 'Answers' => {
                'Answer' => [{'QuestionID' => 'yay', 'AnswerID' => '1', 'AnswerText' => 'NO!'}]}}]}}}})
      end
      
      context 'when the returning API hash formatted correctly' do
        context 'it returns an application schema object via:' do
          def assert_application_model_correct(result)
            expect(result).to be_an_instance_of Cb::CbApplicationSchema
            expect(result.questions).to be_a Array
            expect(result.questions.count).to eq result.total_questions
            expect(result.questions.first).to be_a CbApplicationSchema::CbQuestionSchema
            expect(result.questions.first.answers.first).to be_a CbApplicationSchema::CbAnswerSchema
          end

          it 'the Cb module convenience method' do
            assert_application_model_correct Cb.application.for_job('job-did-here')
          end

          it 'the API client itself' do
            assert_application_model_correct Cb::ApplicationApi.for_job('job-did-here')
          end
        end
      end

    end # #for_job

    context 'application submission methods' do
      let(:app) do
        args = { :job_did => 'did', :site_id => 'bogus', :co_brand => 'bogus', :resume_file_name => 'bogus', :resume => 'encoded' }
        app = Cb::CbApplication.new(args)
        app.test = true
        app.add_answer('ApplicantName', 'Foo Bar')
        app.add_answer('ApplicantEmail', 'DontSpamMeBro@gmail.com')
        app
      end

      def stub_app_submission_for(application_api_url, response_content)
        stub_request(:post, uri_stem(application_api_url)).with(:body => anything).
          to_return(:body => response_content.to_json)
      end
      
      def submit_app_via(apply_method_to_use)
        Cb::ApplicationApi.send(apply_method_to_use, app)
      end

      def assert_blank_redirect_url(app)
        app.redirect_url.blank?.should eq true
      end

      { # #submit_app and #submit_registered_app work exactly the same - metaprogram their tests!
        '#submit_app'            => { :uri => Cb.configuration.uri_application_submit,     :method_name => :submit_app},
        '#submit_registered_app' => { :uri => Cb.configuration.uri_application_registered, :method_name => :submit_registered_app}
      }.each do |method_name, info|

        context method_name do
          let(:uri)               { info[:uri] }
          let(:method_under_test) { info[:method_name] }

          it 'raises exception for incorrect input type (anything other than Cb::CbApplication)' do
            expect { Cb::ApplicationApi.send(method_under_test, Object.new) }.
              to raise_error Cb::IncomingParamIsWrongTypeException
          end

          context 'when response hash contains enough data' do
            before :each do
              body = { 'ResponseApplication' => { 'RedirectURL' => 'http://delicious.baconmobile.com' }}
              stub_app_submission_for(uri, body)
            end

            it 'the same application object that it took as input is returned' do
              returned_app = submit_app_via(method_under_test)
              returned_app.should eq app
              returned_app.object_id.should eq app.object_id
            end

            it 'sets redirect_url on the application' do
              returned_app = submit_app_via(method_under_test)
              returned_app.redirect_url.should eq 'http://delicious.baconmobile.com'
            end
          end

          context 'when missing ResponseApplication field' do
            it 'app redirect url is set to a blank string' do
              stub_app_submission_for(uri, Hash.new)
              assert_blank_redirect_url submit_app_via(method_under_test)
            end
          end

          context 'when missing RedirectURL field' do
            it 'app redirect url is set to a blank string' do
              stub_app_submission_for(uri, { 'ResponseApplication' => { 'lol' => 'nope' }})
              assert_blank_redirect_url submit_app_via(method_under_test)
            end
          end

          context 'when ResponseApplication node does not have hash content' do
            it 'raises NoMethodError' do
              stub_app_submission_for(uri, { 'ResponseApplication' => 'lol' })
              expect { submit_app_via(method_under_test) }.to raise_error NoMethodError
            end
          end
        end

      end
    end # application submission methods

  end
end
