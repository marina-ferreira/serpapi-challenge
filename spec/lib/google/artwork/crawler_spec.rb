# frozen_string_literal: true

ARTIST_HTML_FILE_PATH = "picasso-paintings.html"

RSpec.describe Google::Artwork::Crawler do
  describe "#execute" do
    subject(:result) { described_class.new(ARTIST_HTML_FILE_PATH).execute }

    it "should return the correct shape" do
      expect(result[:artworks]).to be_an(Array)
    end
  end
end
