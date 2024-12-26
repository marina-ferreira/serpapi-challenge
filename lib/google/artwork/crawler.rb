# frozen_string_literal: true

require "nokogiri"
require "fileutils"
require "logger"

module Google
  module Artwork
    class Crawler
      INPUT_DIR = "files"
      LOGS_DIR = "log"
      LOGS_PATH = "#{LOGS_DIR}/crawler.log"

      attr_reader :html_path, :logger

      def initialize(html_path)
        @html_path = html_path
        FileUtils.mkdir_p(LOGS_DIR)
        @logger = ::Logger.new(LOGS_PATH)
      end

      def self.execute(html_path)
        new(html_path).execute
      end

      def execute
        { artworks: [] }
      end
    end
  end
end
