# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sitemap/ping/version'

Gem::Specification.new do |spec|
  spec.name = 'sitemap-ping'
  spec.version = Sitemap::Ping::VERSION
  spec.authors = ['Tom Richards']
  spec.email = ['tom@tomrichards.net']

  spec.summary = 'A library to inform search engines of sitemap updates.'
  spec.description = <<~DESCRIPTION
    This gem provides an idiomatic library for notifying search engines of
    sitemap updates, as well as a reusable rake task for easy inclusion into
    existing projects.
  DESCRIPTION

  spec.homepage = 'https://github.com/t-richards/sitemap-ping'
  spec.license = 'MIT'

  all_files = `git ls-files -z`.split("\x0")
  spec.files = all_files.grep(%r{^(lib)/})
  spec.require_paths = ['lib']
  spec.extra_rdoc_files = %w[README.md LICENSE.txt]

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'irb', '~> 1.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-rg', '~> 5.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rdoc', '~> 6.1'
  spec.add_development_dependency 'rubocop', '~> 0.63'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'webmock', '~> 3.5'
end
