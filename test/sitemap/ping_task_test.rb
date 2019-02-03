# frozen_string_literal: true

require 'test_helper'

module Sitemap
  class PingTaskTest < Minitest::Test
    def test_it_is_initializable_with_no_args
      result = Sitemap::PingTask.new
      refute_nil(result)
    end

    def test_it_is_initializable_with_task_name
      result = Sitemap::PingTask.new(:ping)
      refute_nil(result)
      assert_nil(result.sitemap_url)
    end

    def test_it_is_initializable_with_block
      result = Sitemap::PingTask.new do |pt|
        pt.sitemap_url = 'not-nil'
      end
      refute_nil(result)
      assert_equal(result.sitemap_url, 'not-nil')
    end

    def test_it_is_initializable_with_sitemap
      result = Sitemap::PingTask.new(:ping, "foo.xml")
      assert_equal(result.sitemap_url, "foo.xml")
    end
  end
end
