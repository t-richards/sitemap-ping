# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'simplecov'
SimpleCov.start

require 'sitemap/ping'
require 'sitemap/ping_task'

require 'minitest/autorun'
require 'minitest/rg'
require 'webmock/minitest'

WebMock.disable_net_connect!
