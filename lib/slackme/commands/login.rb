# frozen_string_literal: true

require "json"
require "launchy"
require "net/http"
require "uri"

module Slackme
  module Commands
    class Login
      def call
        puts "Logging in..."

        print "Enter your client ID: "
        client_id = $stdin.gets.chomp

        print "Enter your client secret: "
        client_secret = $stdin.gets.chomp

        authorize_url = URI("https://slack.com/oauth/v2/authorize")
        authorize_url.query = URI.encode_www_form({
                                                    user_scope: "users.profile:read",
                                                    redirect_uri: "https://github.com/okonomi/slackme",
                                                    client_id: client_id
                                                  })

        Launchy.open(authorize_url.to_s)

        puts "Please enter the code from the URL:"
        print "code: "
        code = $stdin.gets.chomp

        puts "Exchange the code for an access token..."
        token_url = URI("https://slack.com/api/oauth.v2.access")
        response = Net::HTTP.post_form(token_url, {
                                         code: code,
                                         client_id: client_id,
                                         client_secret: client_secret
                                       })
        pp JSON.parse(response.body)
      end
    end
  end
end
