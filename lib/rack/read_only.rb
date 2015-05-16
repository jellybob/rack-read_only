require "rack/read_only/version"

module Rack
  class ReadOnly
    attr_reader :app, :options

    def initialize(app, options = {})
      @app = app
      @options = options
    end

    def active?
      options[:active]
    end

    def response_body
      options[:response_body]
    end

    def response_status
      options.fetch(:response_status, 503)
    end

    def response_headers
      options.fetch(:response_headers, {
        'Content-Type' => 'application/json'
      })
    end

    def call(env)
      if active? && WRITE_METHODS.include?(env['REQUEST_METHOD'])
        response = Rack::Response.new(
          response_body,
          response_status,
          response_headers
        )

        return response
      end

      app.call(env)
    end
  end
end
