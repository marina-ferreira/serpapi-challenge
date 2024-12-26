require_relative "../../helpers"

module Google
  module Artwork
    class Parser
      LINK_URL_PREFIX = "https://www.google.com"
      TITLE_SELECTOR = ".pgNMRc"
      YEAR_SELECTOR = ".cxzHyb"

      attr_reader :carousel_artwork

      def initialize(carousel_artwork)
        @carousel_artwork = carousel_artwork
      end

      def self.parse(carousel_artwork)
        new(carousel_artwork).parse
      end

      def parse
        return {} if carousel_artwork&.blank?

        title = Helpers::String.sanitize(carousel_artwork.css(TITLE_SELECTOR)&.text)
        href = carousel_artwork.attr("href")
        link = "#{LINK_URL_PREFIX}#{href}"
        image_id, image_url = parse_image.values_at(:image_id, :image_url)

        { title:, link:, image_id:, image_url:, extensions: parse_extensions }
      end

      private

      def parse_image
        image = carousel_artwork.css("img")
        image_id = image.attr("id")&.value
        image_url = image.attr("data-key")&.value || image.attr("data-src")&.value

        { image_id:, image_url: }
      end

      def parse_extensions
        extensions = []
        year = Helpers::String.sanitize(carousel_artwork.css(YEAR_SELECTOR)&.text)
        extensions << year unless year.empty?
      end
    end
  end
end
