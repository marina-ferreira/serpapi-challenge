module Google
  module Artwork
    class ImageReplacerScriptParser
      IMAGE_REPLACER_SCRIPT_TAG = "_setImagesSrc"
      IMAGE_DATA_REGEX = /s='(.*?)';.*?var ii=\['(.*?)'\]/

      attr_reader :document

      def initialize(document)
        @document = document
      end

      def self.parse(document)
        new(document).parse
      end

      def parse
        return {} if image_replacer_script.empty?

        image_replacer_script.scan(IMAGE_DATA_REGEX).each_with_object({}) do |match, acc|
          image_base64_str, image_id = match
          acc[image_id] = Helpers::Base64.sanitize(image_base64_str)
        end
      end

      private

      def scripts
        @scripts ||= document.css("script")
      end

      def image_replacer_script
        @image_replacer_script ||= scripts.filter_map do |script|
          Helpers::String.sanitize(script.text) if script.text.include?(IMAGE_REPLACER_SCRIPT_TAG)
        end.join("")
      end
    end
  end
end
