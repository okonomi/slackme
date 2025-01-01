# frozen_string_literal: true

require_relative "slackme/version"
require_relative "slackme/cli"
require_relative "slackme/commands/login"
require_relative "slackme/commands/user"

module Slackme
  class Error < StandardError; end
  # Your code goes here...
end
