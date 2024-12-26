# frozen_string_literal: true

module Helpers
  class String
    def self.sanitize(str)
      return "" if str&.empty?

      str.strip.squeeze(" ").gsub("\n", "")
    end
  end
end
