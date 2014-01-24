require 'spec_helper'

module Cb::Models
  describe Application do
    let(:response_hash) { YAML.load open('spec/support/response_stubs/application.yml') }
    let(:application_hash) { response_hash['Results'][0] }
    let(:application) { Application.new(application_hash) }

    describe 'Application Models' do
      it 'sets a resume' do
        expect(application.resume).to be_a Application::Resume
      end

      it 'sets a cover letter' do
        expect(application.cover_letter).to be_a Application::CoverLetter
      end

      it 'sets an array of responses' do
        expect(application.responses[0]).to be_a Application::Response
      end
    end

    describe '#is_submitted' do
      let(:application_hash) {
        replace_value_in_response_hash('IsSubmitted', is_submitted)
      }

      context 'When IsSubmitted is nil' do
        let(:is_submitted) { nil }
        it 'sets is_submitted as false' do
          expect(application.is_submitted).to be_false
        end
      end

      context 'When IsSubmitted is "true"' do
        let(:is_submitted) { "true" }
        it 'sets is_submitted as true' do
          expect(application.is_submitted).to be_true
        end
      end

      context 'When IsSubmitted is "false"' do
        let(:is_submitted) { "false" }
        it 'sets is_submitted as true' do
          expect(application.is_submitted).to be_false
        end
      end
    end

    describe 'Other attributes' do
      it 'sets vid' do
        expect(application.vid).to eq 'Visitor ID'
      end
      it 'sets bid' do
        expect(application.bid).to eq 'Browser ID'
      end
      it 'sets sid' do
        expect(application.sid).to eq 'Session ID'
      end
      it 'sets site_id' do
        expect(application.site_id).to eq 'Site ID'
      end
      it 'sets ipath_id' do
        expect(application.ipath_id).to eq 'IPath'
      end
      it 'sets application_did' do
        expect(application.application_did).to eq 'JA******************'
      end
      it 'sets application_did' do
        expect(application.application_did).to eq 'JA******************'
      end
      it 'sets tn_did' do
        expect(application.tn_did).to be_nil
      end
      context 'When response hash has TNDID' do
        let(:application_hash) {
          replace_value_in_response_hash('TNDID', 'TN******************')
        }

        it 'sets tn_did to that value' do
          expect(application.tn_did).to eq 'TN******************'
        end
      end
      it 'sets external_user_id' do
        expect(application.external_user_id).to eq 'XR******************'
      end
      it 'sets redirect_url' do
        expect(application.redirect_url).to be_nil
      end
      context 'When response hash has redirectURL' do
        let(:application_hash) {
          replace_value_in_response_hash('redirectURL', 'google.gov')
        }

        it 'sets redirect_url to that value' do
          expect(application.redirect_url).to eq 'google.gov'
        end
      end
    end

    def replace_value_in_response_hash(key, value)
      hash = response_hash['Results'][0]
      hash[key] = value
      hash
    end

  end
end
