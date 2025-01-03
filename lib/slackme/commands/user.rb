# frozen_string_literal: true

require "json"
require "xdg"

module Slackme
  module Commands
    class User
      def call
        puts "Showing user..."

        token_info = load_token_info
        pp token_info
      end

      private

      def load_token_info
        path = XDG::Config.new.home.join("slackme", "token.json")
        token_info = JSON.parse(path.read) if path.file?

        raise "No token found. Please login first" unless token_info

        token_info
      end
    end
  end
end
