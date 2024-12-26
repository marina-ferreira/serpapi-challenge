# frozen_string_literal: true

module Helpers
  # Provides utility methods for handling Base64 encoded strings,
  class Base64
    BASE64_PADDING_HEX_REGEX = /\\x3d/
    BASE64_PADDING = "="

    def self.sanitize(base64_str)
      base64_str.gsub(BASE64_PADDING_HEX_REGEX, BASE64_PADDING)
    end
  end
end
