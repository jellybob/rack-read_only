require 'spec_helper'
require 'sinatra/base'
require 'rack/test'
require 'rack/read_only'

RSpec.describe 'Read only mode' do
  include Rack::Test::Methods

  class TestEndpoint < Sinatra::Base
    Rack::ReadOnly::ALL_METHODS.each do |m|
      send(m.downcase, '/test') do
        'ok'
      end
    end
  end
  TEST_ENDPOINT = '/test'

  def make_request(method)
    send(method.downcase.to_sym, TEST_ENDPOINT)
  end

  context 'when active' do
    def app
      Rack::Builder.new do
        use Rack::ReadOnly,
          active: true,
          response_body: 'read-only'
        run TestEndpoint
      end
    end

    Rack::ReadOnly::READ_METHODS.each do |m|
      it "allows #{m} requests" do
        make_request m

        expect(last_response.status).to eq(200)
      end
    end

    Rack::ReadOnly::WRITE_METHODS.each do |m|
      it "rejects #{m} requests" do
        make_request m

        expect(last_response.status).to eq(503)
      end
    end

    it 'provides a useful error message when rejecting requests' do
      make_request 'POST'

      expect(last_response.body).to eq('read-only')
    end
  end

  context 'when inactive' do
    def app
      Rack::Builder.new do
        use Rack::ReadOnly, {
          active: false,
          response_body: 'read-only'
        }
        run TestEndpoint
      end
    end

    Rack::ReadOnly::ALL_METHODS.each do |m|
      it "allows #{m} requests" do
        make_request m

        expect(last_response.status).to eq(200)
      end
    end
  end
end
