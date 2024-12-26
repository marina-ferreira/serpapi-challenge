# frozen_string_literal: true

module Helpers
  # Provides utility methods for handling strings,
  class String
    def self.sanitize(str)
      return "" if str&.empty?

      str.strip.squeeze(" ").gsub("\n", "")
    end

    def self.parameterize(str)
      str.downcase.gsub(" ", "-")
    end
  end
end
