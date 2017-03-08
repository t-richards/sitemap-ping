require 'test_helper'

module Sitemap
  class PingTaskTest < Minitest::Test
    def test_it_raises_without_a_sitemap
      assert_raises do
        Sitemap::PingTask.new(:ping)
      end
    end

    def test_it_is_initializable_with_block
      result = Sitemap::PingTask.new do |pt|
        pt.sitemap_url = 'not-nil'
      end
      refute_nil result
    end
  end
end
