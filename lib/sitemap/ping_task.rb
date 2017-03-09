require 'rake'
require 'rake/tasklib'
require 'yaml'

require 'sitemap/ping'

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
      @sitemap_url = try_jekyll_config
      yield self if block_given?
      define
    end

    def try_jekyll_config
      YAML.load_file('_config.yml')['url'] + '/sitemap.xml'
    rescue SystemCallError
      nil
    end

    def define
      raise Sitemap::UrlError if @sitemap_url.nil?

      namespace :sitemap do
        desc @description
        task @name => Array(@deps) do
          @engines.each do |e|
            Sitemap::Ping.ping_sitemap(e, @sitemap_url)
          end
        end
      end
    end
  end
end
