# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
end

require 'sitemap/ping'
require 'sitemap/ping_task'

require 'minitest/autorun'
require 'minitest/rg'
require 'webmock/minitest'

WebMock.disable_net_connect!
