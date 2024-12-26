# frozen_string_literal: true

require_relative "../../helpers"

module Google
  module Artwork
    # Parses artwork details from Google elements for extracting main information
    class Parser
      LINK_URL_PREFIX = "https://www.google.com"
      TITLE_SELECTOR = ".pgNMRc"
      YEAR_SELECTOR = ".cxzHyb"

      attr_reader :artwork

      def initialize(artwork)
        @artwork = artwork
      end

      def self.parse(artwork)
        new(artwork).parse
      end

      def parse
        return {} if artwork&.blank?

        title = Helpers::String.sanitize(artwork.css(TITLE_SELECTOR)&.text)
        href = artwork.attr("href")
        link = "#{LINK_URL_PREFIX}#{href}"
        image_id, image_url = parse_image.values_at(:image_id, :image_url)

        { title:, link:, image_id:, image_url:, extensions: parse_extensions }
      end

      private

      def parse_image
        image = artwork.css("img")
        image_id = image.attr("id")&.value
        image_url = image.attr("data-key")&.value || image.attr("data-src")&.value

        { image_id:, image_url: }
      end

      def parse_extensions
        extensions = []
        year = Helpers::String.sanitize(artwork.css(YEAR_SELECTOR)&.text)
        extensions << year unless year.empty?
      end
    end
  end
end
