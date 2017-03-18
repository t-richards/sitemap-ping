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
    google: 'https://www.google.com/webmasters/sitemaps/ping?sitemap=',
    bing: 'https://www.bing.com/webmaster/ping.aspx?siteMap=',
  }.freeze

  # Utility for sending "ping" update requests over the network
  module Ping
    module_function

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
      uri = URI(ENGINE_BASEURLS[engine] + sitemap_url)
      Net::HTTP.get_response(uri)
    end
  end
end
