module Sitemap
  class UrlError < StandardError
    def message
      'Missing or invalid sitemap URL!'
    end
  end
end
