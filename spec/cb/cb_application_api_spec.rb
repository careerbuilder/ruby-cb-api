require 'spec_helper'

module Cb
  describe Cb::ApplicationApi do
    context '#for_job' do
      def stub_request
        stub_request(:get, uri_stem(Cb.configuration.uri_application)).
          to_return(:body => @body_content.to_json)
      end

      before :each do
        @body_content = {

        }
        stub_request
      end


      it 'should return valid application schema' do
        result = Cb.application.for_job job

        expect(result).to be_an_instance_of Cb::CbApplicationSchema

        # Questions
        expect(result.questions).to be_an_instance_of Array
        expect(result.questions.count).to eql result.total_questions
        result.questions do | qq |
          expect(qq).to be_an_instance_of Cb::CbApplicationSchema::CbQuestionSchema
          expect(qq.answers).to be_an_instance_of Array
          if qq.answers.count > 0
            qq.answers do | aa |
              expect(aa).to be_an_instance_of Cb::CbApplicationSchema::CbAnswerSchema
            end
          end
        end
      end

    end

    context '.submit_app' do
      it 'should get incomplete status message from api' do
        app = Cb::CbApplication.new({:job_did => 'bogus-did', :site_id => 'bogus', :co_brand => 'bogus', :resume_file_name => 'bogus-resume', :resume => 'this-should-be-encoded'})
        app.test = true
        app.add_answer('ApplicantName', 'Foo Bar')
        app.add_answer('ApplicantEmail', 'DontSpamMeBro@gmail.com')

        app = app.submit
        app.cb_response.application_status.should == 'Incomplete'
        app.complete?.should == false
        expect(app.api_error).to be == false
      end
    end
  end
end
