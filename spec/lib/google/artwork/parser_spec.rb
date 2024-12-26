# frozen_string_literal: true

require "pry"

ARTIST_HTML_FILE_PATH = "van-gogh-paintings.html"
ARTWORK_WITH_YEAR_TITLE = "Mulberry Tree"
ARTWORK_WITHOUT_BASE64_TITLE = "Bedroom in Arles"

RSpec.describe Google::Artwork::Parser do
  let(:artworks) do
    crawler = Google::Artwork::Crawler.new(ARTIST_HTML_FILE_PATH)
    crawler.send(:artworks)
  end
  let(:artwork_link) { artworks.css("a").first }
  let(:artwork_link_without_year) do
    artworks.css("a").find { |link| link.text.include?(ARTWORK_WITH_YEAR_TITLE) }
  end
  let(:artwork_link_without_base64_image) do
    artworks.css("a").find { |link| link.text.include?(ARTWORK_WITHOUT_BASE64_TITLE) }
  end

  describe "#parse" do
    subject(:result) { described_class.parse(artwork_link) }

    it "should return the correct shape" do
      expect(result[:title]).to be_an(String)
      expect(result[:link]).to be_an(String)
      expect(result[:image_id]).to be_an(String)
      expect(result[:extensions]).to be_an(Array)
    end

    context "when year is empty" do
      subject(:result) { described_class.parse(artwork_link_without_year) }

      it "should allow empty extensions" do
        expect(result[:extensions]).to be_nil
      end
    end

    context "when base64 image is empty" do
      subject(:result) { described_class.parse(artwork_link_without_base64_image) }

      it "should fallback to image url" do
        expect(result[:image_url]).to be_an(String)
      end
    end
  end
end
