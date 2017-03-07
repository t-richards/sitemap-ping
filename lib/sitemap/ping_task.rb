require 'net/http'
require 'rake'
require 'rake/tasklib'
require 'uri'
require 'yaml'

require 'sitemap/ping/version'

ENGINE_PING_BASEURLS = {
  google: 'https://www.google.com/webmasters/sitemaps/ping?sitemap=',
  bing: 'https://www.bing.com/webmaster/ping.aspx?siteMap='
}.freeze

module Sitemap
  # Rake task for initiating search engine sitmap "ping"s
  class PingTask < Rake::TaskLib
    attr_accessor :name
    attr_accessor :engines
    attr_accessor :description
    attr_accessor :sitemap_url

    def initialize(name = :ping)
      @name = name
      @engines = [:google, :bing]
      @description = 'Inform search engines of updated sitemap contents'
      @deps = []
      @sitemap_url = YAML.load_file('_config.yml')['url'] + '/sitemap.xml'
      yield self if block_given?
      define
    end

    def define
      namespace :sitemap do
        desc @description
        task @name => Array(@deps) do
          ENGINE_PING_BASEURLS.each do |k, v|
            ping_sitemap(v, @sitemap_url) if @engines.include?(k)
          end
        end
      end
    end

    def ping_sitemap(engine_url, sitemap_url)
      uri = URI(engine_url + sitemap_url)

      resp = Net::HTTP.get_response(uri)
      puts "#{resp.message}: #{uri}"
    end
  end
end
