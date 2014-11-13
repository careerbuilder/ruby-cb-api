require 'spec_helper'

module Cb
  describe Cb::Utils::ResponseMap do
    context '.response_for' do

      let(:response_map) { Cb::Utils::ResponseMap }

      it 'should throw an error on a bad entry' do
        expect { response_map.response_for("Hello") }.to raise_error(Cb::Utils::ResponseNotFoundError)
      end

      it 'should test that response_hash_extension is not implemented' do
        expect(response_map.response_for(:response_hash_extension_not_implemented)).to eq(true)
      end

      it 'should test education methods' do
        request_namespace = Cb::Requests::EmailSubscription
        response_namespace = Cb::Responses::EmailSubscription

        expect(response_map.response_for(request_namespace::Retrieve)).to eq response_namespace::Response
        expect(response_map.response_for(request_namespace::Modify)).to eq response_namespace::Response
      end

      it 'should test education methods' do
        request_namespace = Cb::Requests::Education
        response_namespace = Cb::Responses::Education

        expect(response_map.response_for(request_namespace::Get)).to eq response_namespace::Get
      end
      
      it 'should test company methods' do
        request_namespace = Cb::Requests::Company
        response_namespace = Cb::Responses::Company

        expect(response_map.response_for(request_namespace::Find)).to eq(response_namespace::Find)
      end

      it 'should test category methods' do
        request_namespace = Cb::Requests::Category
        response_namespace = Cb::Responses::Category

        expect(response_map.response_for(request_namespace::Search)).to eq(response_namespace::Search)
      end

      it 'should test application external methods' do
        request_namespace = Cb::Requests::ApplicationExternal
        response_namespace = Cb::Responses::ApplicationExternal

        expect(response_map.response_for(request_namespace::SubmitApplication)).to eq(response_namespace::SubmitApplication)
      end

      it 'should test anonymous saved search' do
        request_namespace = Cb::Requests::AnonymousSavedSearch
        response_namespace = Cb::Responses::AnonymousSavedSearch

        expect(response_map.response_for(request_namespace::Create)).to eq(response_namespace::Create)
        expect(response_map.response_for(request_namespace::Delete)).to eq(response_namespace::Delete)
      end

      it 'should test application methods' do
        request_namespace = Cb::Requests::Application
        response_namespace = Cb::Responses::Application

        expect(response_map.response_for(request_namespace::Create)).to eq(response_namespace)
        expect(response_map.response_for(request_namespace::Update)).to eq(response_namespace)
        expect(response_map.response_for(request_namespace::Get)).to eq(response_namespace)
        expect(response_map.response_for(request_namespace::Form)).to eq(Cb::Responses::ApplicationForm)
      end

      it 'should test user methods' do
        request_namespace = Cb::Requests::User
        response_namespace = Cb::Responses::User

        expect(response_map.response_for(request_namespace::ChangePassword)).to eq(response_namespace::ChangePassword)
        expect(response_map.response_for(request_namespace::CheckExisting)).to eq(response_namespace::CheckExisting)
        expect(response_map.response_for(request_namespace::Delete)).to eq(response_namespace::Delete)
        expect(response_map.response_for(request_namespace::Retrieve)).to eq(response_namespace::Retrieve)
        expect(response_map.response_for(request_namespace::TemporaryPassword)).to eq(response_namespace::TemporaryPassword)
      end

      it 'should test resumes work status methods' do
        request_namespace = Cb::Requests::WorkStatus
        response_namespace = Cb::Responses::WorkStatus

        expect(response_map.response_for(request_namespace::List)).to eq response_namespace::List
      end

      it 'maps resume to the correct response object' do
        request_namespace = Cb::Requests::Resumes
        response_namespace = Cb::Responses

        expect(response_map.response_for(request_namespace::Get)).to eq response_namespace::Resume
        expect(response_map.response_for(request_namespace::LanguageCodes)). to eq response_namespace::LanguageCodes
      end

      it 'maps to correct data list response object' do
        request_namespace = Cb::Requests::DataLists
        response_namespace = Cb::Responses

        expect(response_map.response_for(request_namespace::CountryCodes)).to eq response_namespace::CountryCodes
        expect(response_map.response_for(request_namespace::ResumeEducation)).to eq response_namespace::ResumeEducation
      end

      it 'should map resume recommendations to the correct response object' do
        request_namespace = Cb::Requests::Recommendations
        response_namespace = Cb::Responses

        expect(response_map.response_for(request_namespace::Resume)).to eq response_namespace::Recommendations
      end
    end
  end
end
