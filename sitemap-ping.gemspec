# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sitemap/ping/version'

Gem::Specification.new do |spec|
  spec.name = 'sitemap-ping'
  spec.version = Sitemap::Ping::VERSION
  spec.authors = ['Tom Richards']
  spec.email = ['tom@tomrichards.net']

  spec.summary = 'A library to inform search engines of sitemap updates.'
  spec.description = <<-DESCRIPTION
This gem provides an idiomatic library for notifying search engines of sitemap
updates, as well as a reusable rake task for easy inclusion into existing
projects.
  DESCRIPTION

  spec.homepage = 'https://github.com/t-richards/sitemap-ping'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
