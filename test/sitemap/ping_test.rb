# frozen_string_literal: true

require 'test_helper'

class PingTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Sitemap::Ping::VERSION
  end

  def test_that_it_has_a_method
    assert Sitemap::Ping.respond_to?(:ping_sitemap)
  end

  def test_google_ping_works
    stub =
      stub_request(:get, /www\.google\.com/)
      .with(
        headers: {
          'Accept': '*/*',
          'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host': 'www.google.com',
          'User-Agent': 'Ruby'
        }
      )
      .to_return(status: 200)

    response = Sitemap::Ping.ping_sitemap(:google, 'https://example.com/sitemap.xml')

    refute_nil(response)
    assert_requested(stub)
  end

  def test_bing_ping_works
    stub =
      stub_request(:get, /www\.bing\.com/)
      .with(
        headers: {
          'Accept': '*/*',
          'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host': 'www.bing.com',
          'User-Agent': 'Ruby'
        }
      )
      .to_return(status: 200)

    response = Sitemap::Ping.ping_sitemap(:bing, 'https://example.com/sitemap.xml')

    refute_nil(response)
    assert_requested(stub)
  end

  def test_invalid_engines_raises
    google_stub = stub_request(:any, /www\.google\.com/)
    bing_stub = stub_request(:any, /www\.bing\.com/)

    assert_raises Sitemap::EngineError do
      Sitemap::Ping.ping_sitemap(:invalid_engine, 'a')
    end

    assert_not_requested(google_stub)
    assert_not_requested(bing_stub)
  end
end
