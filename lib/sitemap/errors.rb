module Sitemap
  class UrlError < StandardError
    # :nodoc:
    def message
      'Missing or invalid sitemap URL!'
    end
  end
end
