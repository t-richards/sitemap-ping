# frozen_string_literal: true

require 'net/http'
require 'sitemap/ping/version'

# The top-level module for this gem.
module Sitemap
  # A hash that attaches a unique symbol to each search engine's sitemap update
  # URL.
  #
  #   ENGINE_BASEURLS[:google]
  #   # => "https://www.google.com/webmasters/sitemaps/ping?sitemap="
  ENGINE_BASEURLS = {
    google: 'https://www.google.com/webmasters/sitemaps/ping?',
    bing: 'https://www.bing.com/webmaster/ping.aspx?'
  }.freeze

  # Utility for sending "ping" update requests over the network
  module Ping
    module_function

    # Constructs a query string with parameter names based on the search engine.
    def sitemap_params(engine, sitemap_url)
      if engine == :bing
        return URI.encode_www_form('siteMap' => sitemap_url)
      end

      URI.encode_www_form('sitemap' => sitemap_url)
    end

    # Pings the specified +engine+ to request an update of your site's
    # +sitemap_url+. Valid values for +engine+ include <tt>:google</tt> and
    # <tt>:bing</tt>.
    #
    # Returns a <tt>Net::HTTPResponse</tt>.
    #
    #  ping_sitemap(:google, "https://example.com/sitemap.xml")
    #  # => #<Net::HTTPOK 200 OK readbody=true>
    #  ping_sitemap(:bing, "https://example.com/another_sitemap.xml")
    #  # => #<Net::HTTPOK 200 OK readbody=true>
    def ping_sitemap(engine, sitemap_url)
      if ENGINE_BASEURLS[engine].nil?
        raise EngineError.new, "Invalid engine #{engine} specified"
      end

      full_url = ENGINE_BASEURLS[engine] + sitemap_params(engine, sitemap_url)
      Net::HTTP.get_response(URI(full_url))
    end
  end
end
