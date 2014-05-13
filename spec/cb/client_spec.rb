require 'spec_helper'

module Cb
  describe Cb::Client do

    context 'initialize' do
      it 'should use the default callback method' do
        client = Cb::Client.new()
        client.callback_method.should == client.method(:default_callback_method)
      end
      it 'should pass nil as callback' do
        expect{ Cb::Client.new(nil) }.to raise_error
      end
      it 'should pass a correct callback' do
        tester = CallbackTest.new()
        client = Cb::Client.new(tester.method(:callback_method))
        client.callback_method.should == tester.method(:callback_method)
      end
    end

    context 'callback' do
      before :each do
        @callback_value = "copy that ghost rider"
      end

      it "should call the default callback method" do
        client = Cb::Client.new()
        client.callback_method.call(@callback_value)
        client.returned_callback_value.should == @callback_value
      end
      it "should call a custom callback method" do
        callback_object = CallbackTest.new

        client = Cb::Client.new(callback_object.method(:callback_method))
        client.callback_method.call(@callback_value)
        callback_object.callback_value.should == @callback_value
      end
    end

    context 'api call' do

      let(:mock_api) { double(Cb::Utils::Api) }

      before :each do
        @client = Cb::Client.new
      end

      context "post" do
        before :each do
          mock_api.stub(:cb_post).and_return(Hash.new)
          mock_api.stub(:append_api_responses)
          Cb::Utils::Api.stub(:new).and_return(mock_api)

          @request = RequestTest.new(:post)
        end

        it 'should call the api using post' do
          mock_api.should_receive(:cb_post).
              with("parts unknown", {:query=>nil, :headers=>nil, :body=>nil}, @client.method(:default_callback_method)).
              and_return(Hash.new)

          @client.make_request(@request)
        end
      end

      context "get" do
        before :each do
          mock_api.stub(:cb_get).and_return(Hash.new)
          mock_api.stub(:append_api_responses)
          Cb::Utils::Api.stub(:new).and_return(mock_api)

          @request = RequestTest.new(:get)
        end

        it 'should call the api using post' do
          mock_api.should_receive(:cb_get).
              with("parts unknown", {:query=>nil, :headers=>nil, :body=>nil}, @client.method(:default_callback_method)).
              and_return(Hash.new)

          @client.make_request(@request)
        end
      end

      context "put" do
        before :each do
          mock_api.stub(:cb_put).and_return(Hash.new)
          mock_api.stub(:append_api_responses)
          Cb::Utils::Api.stub(:new).and_return(mock_api)

          @request = RequestTest.new(:put)
        end

        it 'should call the api using post' do
          mock_api.should_receive(:cb_put).
              with("parts unknown", {:query=>nil, :headers=>nil, :body=>nil}, @client.method(:default_callback_method)).
              and_return(Hash.new)

          @client.make_request(@request)
        end
      end

    end

  end
end

class RequestTest
  attr_reader :body, :headers, :query, :uri_endpoint, :http_method, :response_object

  def initialize(arg)
    @http_method = arg
    @uri_endpoint = "parts unknown"
    @response_object = ResponseTest
  end
end

class ResponseTest
  attr_reader :response

  def initialize(arg)
    @response = arg
  end

end

class CallbackTest
  attr_reader :callback_value
  def initialize
    @callback_value = false
  end
  def callback_method(arg)
    @callback_value = arg
  end
end