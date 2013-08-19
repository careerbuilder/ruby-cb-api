require 'spec_helper'


module Cb
  describe Cb::ApplicationApi do
    context '.for_job' do
      it 'should return valid application schema', :vcr => {:cassette_name => 'job/application/for_job'} do
          search = Cb.job_search_criteria.location('Atlanta, GA').radius(150).keywords('customcodes:CBDEV_applyurlno').search()
          job = search[Random.new.rand(0..24)]

          result = Cb.application.for_job job

          expect(result.cb_response.errors).to satisfy { | obj | obj.nil? || obj.count == 0 }

          expect(result).to be_an_instance_of Cb::CbApplicationSchema
          expect(result.did.length).to be >= 19
          expect(result.title.length).to be >= 1
          expect(result.requirements.length).to be >= 1
          expect(result.apply_url.length).to be >= 1
          expect(result.submit_service_url.length).to be >= 1
          expect(result.is_shared_apply).to satisfy { | obj | obj.is_a?(TrueClass) || obj.is_a?(FalseClass)}
          expect(result.total_questions).to be >= 1
          expect(result.total_required_questions).to be >= 1

          # Questions
          expect(result.questions).to be_an_instance_of Array
          expect(result.questions.count).to eql result.total_questions
          result.questions do | qq |
            expect(qq).to be_an_instance_of Cb::CbApplicationSchema::CbQuestionSchema
            expect(qq.id.length).to be >= 1
            expect(qq.type.length).to be >= 1
            expect(qq.required).to satisfy { | obj | obj.is_a?(TrueClass) || obj.is_a?(FalseClass)}
            expect(qq.format.length).to be >= 1
            expect(qq.text.length).to be >= 1

            # Answers
            expect(qq.answers).to be_an_instance_of Array
            if qq.answers.count > 0
              qq.answers do | aa |
                expect(aa).to be_an_instance_of Cb::CbApplicationSchema::CbAnswerSchema
                expect(aa.question_id.length).to be >= 1
                expect(aa.id.length).to be >= 1
                expect(aa.text.length).to be >= 1
              end
            end
          end
      end

      it 'should return error for bogus job did', :vcr => {:cassette_name => 'job/application/for_job'} do
        result = Cb.application.for_job 'bogus-job-did'

        expect(result.cb_response.errors).to be_an_instance_of Array
        expect(result.cb_response.errors[0].length).to be >= 1
      end
    end

    context '.submit_app' do
      it 'should send application info to api', :vcr => {:cassette_name => 'job/application/submit_app'} do

      end

      it 'should get incomplete status message from api' do
        app = Cb::CbApplication.new({:job_did => 'bogus-did', :site_id => 'bogus', :co_brand => 'bogus', :resume_file_name => 'bogus-resume', :resume => 'this-should-be-encoded'})
        app.test = true
        app.add_answer('ApplicantName', 'Foo Bar')
        app.add_answer('ApplicantEmail', 'DontSpamMeBro@gmail.com')

        app = app.submit
        app.cb_response.application_status.should == 'Incomplete'
        app.complete?.should == false
      end
    end
  end
end