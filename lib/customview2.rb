require 'her'
require 'faraday'
require 'faraday_middleware'
require "customview2/version"


module Customview2
  class << self
    attr_accessor :host, :jwt

    def api
      @api ||= Her::API.new    
    end

    def connect(email:, api_key:, url:)

      self.host  = url
      
      conn = Faraday.new(:url => "#{self.host}") do |c|
        c.request  :url_encoded
        c.response :json
        c.adapter  Faraday.default_adapter
      end

      response = conn.post "/api/v1/auth" do |req|
        req.body = { email: email, token: api_key}
      end

      if self.jwt = response.body["jwt"]
      else
        raise Customview2::AuthenticationFailed
      end

      Customview2::api.setup url: self.host do |c|
        c.headers["Authorization"] = "#{self.jwt}"
        c.use Faraday::Request::UrlEncoded
        c.use Her::Middleware::DefaultParseJSON
        c.use Faraday::Adapter::NetHttp
      end
    end

    # def config
    #   yield self
    # end

    require 'customview2/project'
  end

  class AuthenticationFailed < StandardError
  
  end
end
