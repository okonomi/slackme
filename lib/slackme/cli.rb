# frozen_string_literal: true

module Slackme
  class CLI
    def self.run(argv)
      case argv[0]
      when "login"
        puts "Logging in..."
      when "user"
        puts "Showing user..."
      else
        puts "Usage: slackme [login|user]"
      end
    end
  end
end
