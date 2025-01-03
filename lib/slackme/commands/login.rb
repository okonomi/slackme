# frozen_string_literal: true

require "launchy"
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
      end
    end
  end
end
