# frozen_string_literal: true

require "net/http"
require "uri"

module Slackme
  class HTTP
    def self.get(url, headers: nil)
      request(url) do |http, uri|
        http.get(uri.path, headers)
      end
    end

    def self.post(url, headers: nil, body: nil)
      request(url) do |http, uri|
        body = URI.encode_www_form(body) if body.is_a?(Hash)
        http.post(uri.path, body, headers)
      end
    end

    private_class_method def self.request(url)
      uri = URI(url)
      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
        yield(http, uri) if block_given?
      end
    end
  end
end
