# frozen_string_literal: true

module Sitemap
  # PingError is the base class from which other exceptions are derived
  class PingError < StandardError; end

  # UrlError is raised when the sitemap URL is not valid.
  class UrlError < PingError; end

  # EngineError is raised when an invalid search engine is specified
  class EngineError < PingError; end
end
