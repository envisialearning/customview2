module Customview2
  class Reports

    class << self

      #used for TruthTeller report, not general use
      def get_campaign_report(authentication={}, id=nil, params = {})
        host  = authentication[:url]
        
        conn = Faraday.new(:url => "#{host}") do |c|
          c.request  :url_encoded
          c.response :json
          c.adapter  Faraday.default_adapter
        end

        response = conn.post "/api/v1/auth" do |req|
          req.body = { email: authentication[:email], token: authentication[:api_key]}
        end

        if jwtoken = response.body["jwt"]
        else
          raise Customview2::AuthenticationFailed
        end

        conn = Faraday.new(:url => "#{host}") do |c|
          c.headers["Authorization"] = "#{jwtoken}"
          c.request  :url_encoded
          c.response :json
          c.adapter  Faraday.default_adapter
        end

        response = conn.post("/api/v1/projects/#{id}/report", params)

        return response.body
      end

    end
  end
end