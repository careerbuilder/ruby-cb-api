require 'spec_helper'

module Cb
  describe ResponseValidator do

    let(:response)          { double(HTTParty::Response) }
    let(:response_property) { double('HTTParty::Response.response') }

    before :each do
      response.stub(:response).and_return(response_property)
      response.stub(:code).and_return(200)
    end

    it 'should return empty hash when body is empty' do
       response.response.stub(:body).and_return(String.new)
       validation = ResponseValidator.validate(response)
       validation.empty?.should be_true
    end

    it 'should return empty hash when body is improper json/xml' do
      response.response.stub(:body).and_return('json')
      validation = ResponseValidator.validate(response)
      validation.empty?.should be_true
    end

    it 'should return empty hash when response is nil' do
      response = nil
      validation = ResponseValidator.validate(response)
      validation.empty?.should be_true
    end

    it 'should return empty hash when url is invalid' do
      response.stub(:code).and_return 404
      response.response.stub(:body).and_return('<!DOCTYPE html></html>')
      validation = ResponseValidator.validate(response)
      validation.empty?.should be_true
    end

    it 'should return a full json hash when response status is not 200 and content is json' do
      response.response.stub(:body).and_return('{"TestJson":{"Test":"True"}}')
      validation = ResponseValidator.validate(response)
      validation.empty?.should be_false
    end

    it 'should return a blank json hash when status is not 200 and content is html' do
      response.response.stub(:body).and_return('<!DOCTYPE html></html>')
      validation = ResponseValidator.validate(response)
      validation.empty?.should be_true
    end

    context 'when there are JSON parsing errors' do
      context 'and the content payload is not XML' do
        it 'returns an empty hash' do
          response.response.stub(:body).and_return('yay not json')
          validation = ResponseValidator.validate(response)
          expect(validation).to eq Hash.new
        end
      end

      context 'and the content payload is XML' do
        it 'returns the XML hashified' do
          xml = '<yo><this><isxml>yay</isxml></this></yo>'
          response.response.stub(:body).and_return(xml)
          validation = ResponseValidator.validate(response)
          expect(validation).to be_an_instance_of Hash
          expect(validation).to eq({"this"=>[{"isxml"=>["yay"]}]})
        end

        it 'returns an empty hash when there are errors' do
          xml = '<Response><Errors><Error>whoa!</Error></Errors></Response>'
          response.response.stub(:body).and_return(xml)
          validation = ResponseValidator.validate(response)
          expect(validation).to be_an_instance_of Hash
          expect(validation.empty?).to eq true
        end
      end
    end

  end
end
