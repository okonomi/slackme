# frozen_string_literal: true

module Slackme
  class CLI
    def self.run(argv)
      case argv[0]
      when "login"
        Slackme::Commands::Login.new.call
      when "user"
        Slackme::Commands::User.new.call
      else
        puts "Usage: slackme [login|user]"
      end
    end
  end
end
