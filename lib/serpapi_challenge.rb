# frozen_string_literal: true

require_relative "serpapi_challenge/version"

require_relative "google/artwork/crawler"
require_relative "google/artwork/parser"
require_relative "google/artwork/image_replacer_script_parser"
require_relative "helpers"

module SerpapiChallenge
  # Base error class for all SerpApi Challenge specific errors.
  # Provides common error handling functionality including error codes
  # and formatted error messages.
  class BaseError < StandardError
    ERROR_CODE = 400

    def description
      "Something went wrong. Please, try again."
    end

    def message
      "[#{self.class::ERROR_CODE}] #{description}"
    end
  end

  # Error raised when required HTML elements are not found during parsing
  class HTMLError < BaseError
    def description
      "HTML Element not found"
    end
  end

  # Error raised when an artist's information cannot be found
  class ArtistError < BaseError
    def description
      "Artist not found"
    end
  end
end
