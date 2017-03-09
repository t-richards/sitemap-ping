require 'net/http'

require 'sitemap/ping/version'

ENGINE_BASEURLS = {
  google: 'https://www.google.com/webmasters/sitemaps/ping?sitemap=',
  bing: 'https://www.bing.com/webmaster/ping.aspx?siteMap='
}.freeze

module Sitemap
  # Utility for sending "ping" update requests over the network
  module Ping
    module_function

    def ping_sitemap(engine_sym, sitemap_url)
      uri = URI(ENGINE_BASEURLS[engine_sym] + sitemap_url)

      resp = Net::HTTP.get_response(uri)
      puts "#{resp.message}: #{uri}"
    end
  end
end
