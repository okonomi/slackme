# frozen_string_literal: true

require "net/http"
require "uri"

module Slackme
  class HTTP
    def self.get(url, headers: nil)
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"

      http.get(uri.path, headers)
    end

    def self.post(url, headers: nil, body: nil)
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"

      body = URI.encode_www_form(body) if body.is_a?(Hash)

      http.post(uri.path, body, headers)
    end
  end
end
