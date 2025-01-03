# frozen_string_literal: true

require "json"
require "xdg"

module Slackme
  module Commands
    class User
      def call
        puts "Showing user..."

        token_info = load_token_info
        user = get_current_user(token_info)
        pp user["profile"]
      end

      private

      def load_token_info
        path = XDG::Config.new.home.join("slackme", "token.json")
        token_info = JSON.parse(path.read) if path.file?

        raise "No token found. Please login first" unless token_info

        token_info
      end

      def get_current_user(token_info)
        uri = URI("https://slack.com/api/users.profile.get")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == "https"

        headers = { authorization: "Bearer #{token_info.dig("authed_user", "access_token")}" }
        response = http.get(uri.path, headers)

        JSON.parse(response.body)
      end
    end
  end
end
