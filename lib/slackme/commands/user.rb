# frozen_string_literal: true

require "json"
require "xdg"

require_relative "../http"

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
        token = token_info.dig("authed_user", "access_token")

        response = Slackme::HTTP.get(
          "https://slack.com/api/users.profile.get",
          headers: { authorization: "Bearer #{token}" }
        )

        JSON.parse(response.body)
      end
    end
  end
end
