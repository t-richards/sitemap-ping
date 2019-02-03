# frozen_string_literal: true

require 'rake'
require 'rake/tasklib'
require 'uri'
require 'yaml'

require 'sitemap/ping'
require 'sitemap/errors'

module Sitemap
  # Rake task for easy manual inclusion into your own Jekyll project.
  class PingTask < Rake::TaskLib
    # The name of this task.
    attr_accessor :name

    # Other rake tasks on which this task depends.
    attr_accessor :deps

    # Search engines to ping.
    attr_accessor :engines

    # The description of this task.
    attr_accessor :description

    # The URL of the sitemap which will be sent to each search engine.
    attr_accessor :sitemap_url

    # Default constructor for this task. See +README.md+ for usage instructions.
    def initialize(name = :ping)
      @name = name
      @engines = %i[google bing]
      @description = 'Inform search engines of updated sitemap contents'
      @deps = []
      @sitemap_url = try_jekyll_config
      yield self if block_given?
      define
    end

    # Obtains the baseurl from Jekyll's _config.yml file.
    def try_jekyll_config
      config = YAML.load_file('_config.yml')
      URI.join(config['url'], config['baseurl'], '/sitemap.xml').to_s
    rescue SystemCallError
      nil
    end

    # :nodoc:
    def define
      namespace :sitemap do
        desc @description
        task @name => Array(@deps) do
          raise Sitemap::UrlError, 'Missing sitemap URL' if @sitemap_url.nil?

          @engines.each do |e|
            result = Sitemap::Ping.ping_sitemap(e, @sitemap_url)
            puts "#{result.message}: #{result.uri}"
          end
        end
      end
    end
  end
end
