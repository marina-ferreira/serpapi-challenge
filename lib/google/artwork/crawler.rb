# frozen_string_literal: true

require "nokogiri"
require "fileutils"
require "logger"

require_relative "./parser"

module Google
  module Artwork
    class Crawler
      INPUT_DIR = "files"
      LOGS_DIR = "log"
      LOGS_PATH = "#{LOGS_DIR}/crawler.log"
      ARTWORK_GRID_SELECTOR = '[data-attrid="kc:/visual_art/visual_artist:works"]'

      attr_reader :html_path, :logger

      def initialize(html_path)
        @html_path = html_path
        FileUtils.mkdir_p(LOGS_DIR)
        @logger = ::Logger.new(LOGS_PATH)
      end

      def self.execute(html_path)
        new(html_path).execute
      end

      def execute(artwork_parser: Parser)
        raise SerpapiChallenge::HTMLError unless document
        raise SerpapiChallenge::HTMLError unless artworks

        artwork_links = artworks.css("a")

        raise SerpapiChallenge::HTMLError if artwork_links&.empty?

        artworks = artwork_links.map do |artwork_link|
          data = artwork_parser.parse(artwork_link)

          {
            title: data[:title],
            extensions: data[:extensions],
            link: data[:link]
          }.compact
        rescue StandardError => e
          logger.error(e.message)
          logger.info(artwork_link)
          raise
        end

        { artworks: }
      end

      private

      def document
        return unless html_page

        @document ||= Nokogiri::HTML(html_page.read)
      end

      def artworks
        return unless document

        @artworks ||= document.css(ARTWORK_GRID_SELECTOR).first
      end

      def html_page
        html_full_path = File.join(INPUT_DIR, html_path)
        File.open(html_full_path, "r")
      rescue StandardError
        raise SerpapiChallenge::ArtistError
      end
    end
  end
end

pp Google::Artwork::Crawler.execute("van-gogh-paintings.html")
