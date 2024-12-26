# frozen_string_literal: true

require_relative "serpapi_challenge/version"

require_relative "google/artwork/crawler"

module SerpapiChallenge
  class BaseError < StandardError
    ERROR_CODE = 400
    def initialize
      super
    end

    def description
      "Something went wrong. Please, try again."
    end

    def message
      "[#{self.class::ERROR_CODE}] #{description}"
    end
  end

  class ArtistError < BaseError
    def initialize
      super
    end

    def description
      "Artist not found"
    end
  end
end
