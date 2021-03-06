# sitemap-ping

[![CircleCI Build Status](https://img.shields.io/circleci/project/github/t-richards/sitemap-ping/master.svg?style=flat-square)](https://circleci.com/gh/t-richards/sitemap-ping/)
[![Inline docs](https://inch-ci.org/github/t-richards/sitemap-ping.svg?branch=master&style=flat-square)](http://inch-ci.org/github/t-richards/sitemap-ping)
[![Gem Version](https://img.shields.io/gem/v/sitemap-ping.svg?style=flat-square)](https://rubygems.org/gems/sitemap-ping)

This library and rake task enables you to easily inform search engines when you
update your `sitemap.xml`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sitemap-ping'
```

And then execute:

```bash
$ bundle
```

## Usage

The easiest (manual) method is to invoke this gem via your project's `Rakefile`.

### Default task configuration

Add the `sitemap:ping` task with a default configuration suitable for a Jekyll
site:

```ruby
require 'sitemap/ping_task'

Sitemap::PingTask.new
```

This task will (a) read your Jekyll site configuration and (b) assume you're
using the `jekyll-sitemap` plugin. For example, given this site configuration in
`_config.yml`:

```yml
url: https://example.com
baseurl: ''
```

PingTask will assume your sitemap is located at `https://example.com/sitemap.xml`

### Customizing the task configuration

PingTask accepts a custom task name via constructor argument. Additional
configuration can be specified by passing a block:

```ruby
require 'sitemap/ping_task'

Sitemap::PingTask.new(:myping) do |pt|
  pt.description = 'My custom task description'
  pt.engines = [:google] # Valid options are :google and/or :bing
  pt.sitemap_url = 'https://example.com/custom-sitemap.xml' # Override auto-detection from _config.yml
end
```

## Development

```bash
# After checking out the repo, install dependencies
$ bin/setup

# Run tests
$ bin/rake test

# Open an interactive prompt that will allow you to experiment.
$ bin/console
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/t-richards/sitemap-ping.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
